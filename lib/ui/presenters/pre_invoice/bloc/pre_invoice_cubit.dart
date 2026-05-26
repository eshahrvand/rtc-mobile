import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../config/config.dart';
import '../../../../config/regex_national_number_validator.dart';
import '../../../../data/models/pre_invoice_model.dart';
import '../../../../locator.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../repository/customers/customers_repository.dart';
import '../../../../data_source/remote/catalog/model/product_dto_model.dart';
import '../../../../data_source/remote/plans/model/plan_dto_model.dart';
import '../../../../data_source/remote/customers/model/customer_dto_model.dart';
import '../../media_picker/media_picker.dart';
import 'pre_invoice_state.dart';

class PreInvoiceCubit extends Cubit<PreInvoiceState> {
  final _plansRepo = sl<PlansRepository>();
  final _productRepo = sl<ProductRepository>();
  final _customerRepo = sl<CustomersRepository>();
  final ImagePicker _picker = ImagePicker();
  Timer? _debounce;

  PreInvoiceCubit() : super(const PreInvoiceState());

  void init() {
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));

    _plansRepo
        .getSubPlans()
        .then((response) {
          final plans = response.results.map((dto) {
            return CreditPlanItemModel(
              id: dto.id,
              logo: dto.creditPlan.image?.file ?? 'assets/images/wallet.svg',
              providerName: dto.creditPlan.name,
              planName: 'طرح ${dto.repaymentDurationMonths} ماهه',
              validityDuration: '۴۸ ساعت',
            );
          }).toList();

          final chips = [
            PreInvoiceChipModel(id: 1, label: 'دسته بندی', opensBottomSheet: true),
            PreInvoiceChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
            PreInvoiceChipModel(id: 3, label: 'نمایش کالاهای موجود'),
          ];

          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.success,
              creditPlans: plans,
              filterChips: chips,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

  void goToStep(PreInvoiceStep step) {
    if (step == PreInvoiceStep.products && state.selectedCreditPlanId != null) {
      _loadProducts();
    }
    if (step == PreInvoiceStep.documents && state.customerInfo != null) {
      _submitCustomerInfo();
      return;
    }
    emit(state.copyWith(currentStep: step, isEditMode: false));
  }

  void _submitCustomerInfo() {
    final info = state.customerInfo!;
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));

    final body = {
      'first_name': info.firstName,
      'last_name': info.lastName,
      'national_id': info.nationalId,
      'mobile': info.phoneNumber,
      'postal_code': info.postalCode,
      'address': info.address,
    };

    Future<CustomerDtoModel> request;
    if (state.isExistingCustomer && info.id != null) {
      request = _customerRepo.updateCustomer(info.id!, body);
    } else {
      request = _customerRepo.createCustomer(body);
    }

    request.then((response) {
      emit(state.copyWith(
        status: PreInvoiceRequestStatus.success,
        customerInfo: info.copyWith(id: response.id),
        isExistingCustomer: true,
        currentStep: PreInvoiceStep.documents,
        isEditMode: false,
      ));
    }).catchError((e) {
      emit(state.copyWith(
        status: PreInvoiceRequestStatus.error,
        errorMessage: 'خطا در ثبت اطلاعات مشتری',
      ));
    });
  }

  void _loadProducts() {
    if (state.selectedCreditPlanId == null) return;
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));

    _productRepo
        .getProducts(
          subPlanId: state.selectedCreditPlanId!,
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
          categoryId: state.selectedCategoryId,
        )
        .then((response) {
          final products = response.results
              .map((dto) => _mapProductDtoToModel(dto))
              .toList();
          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.success,
              allProducts: products,
              filteredProducts: products,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

  PreInvoiceProductModel _mapProductDtoToModel(ProductDtoModel dto) {
    final formatter = NumberFormat('#,###', 'en_US');
    return PreInvoiceProductModel(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.featuredImage?.file ?? '$baseImage/frame1.png',
      price: formatter.format(dto.planPrice ?? 0),
      oldPrice: dto.basePrice != null ? formatter.format(dto.basePrice!) : null,
      discount: dto.discountPct != null ? '${dto.discountPct}%' : null,
      inventory: dto.stockQty.toString(),
      isAvailable: dto.stockQty > 0,
    );
  }

  void enterEditMode(PreInvoiceStep step) {
    emit(state.copyWith(currentStep: step, isEditMode: true));
  }

  void exitEditMode() {
    emit(state.copyWith(currentStep: PreInvoiceStep.review, isEditMode: false));
  }

  void onCreditPlanSelected(String id) {
    emit(state.copyWith(selectedCreditPlanId: id));
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    _loadProducts();
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _loadProducts();
    });
  }

  void onCategorySelected(String? categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
    _loadProducts();
  }

  void onChipSelected(int index) {
    emit(state.copyWith(selectedChipIndex: index));
  }

  void toggleShowAvailableOnly() {
    emit(state.copyWith(showAvailableOnly: !state.showAvailableOnly));
    _loadProducts();
  }

  void addToCart(PreInvoiceProductModel product) {
    final existingIndex = state.cartItems.indexWhere((item) => item.productId == product.id);
    final updatedCart = List<CartItemModel>.from(state.cartItems);

    if (existingIndex != -1) {
      final existingItem = updatedCart[existingIndex];
      updatedCart[existingIndex] = CartItemModel(
        productId: existingItem.productId,
        name: existingItem.name,
        imageUrl: existingItem.imageUrl,
        price: existingItem.price,
        oldPrice: existingItem.oldPrice,
        discount: existingItem.discount,
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedCart.add(CartItemModel(
        productId: product.id,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
        oldPrice: product.oldPrice,
        discount: product.discount,
        quantity: 1,
      ));
    }
    emit(state.copyWith(cartItems: updatedCart));
    _updateSummary();
  }

  void increaseQuantity(String productId) {
    final updatedCart = List<CartItemModel>.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      final item = updatedCart[index];
      updatedCart[index] = CartItemModel(
        productId: item.productId,
        name: item.name,
        imageUrl: item.imageUrl,
        price: item.price,
        oldPrice: item.oldPrice,
        discount: item.discount,
        quantity: item.quantity + 1,
      );
      emit(state.copyWith(cartItems: updatedCart));
      _updateSummary();
    }
  }

  void removeFromCart(String productId) {
    final updatedCart = List<CartItemModel>.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      if (updatedCart[index].quantity > 1) {
        final existingItem = updatedCart[index];
        updatedCart[index] = CartItemModel(
          productId: existingItem.productId,
          name: existingItem.name,
          imageUrl: existingItem.imageUrl,
          price: existingItem.price,
          oldPrice: existingItem.oldPrice,
          discount: existingItem.discount,
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedCart.removeAt(index);
      }
    }
    emit(state.copyWith(cartItems: updatedCart));
    _updateSummary();
  }

  void deleteFromCart(String productId) {
    final updatedCart = List<CartItemModel>.from(state.cartItems)
      ..removeWhere((item) => item.productId == productId);
    emit(state.copyWith(cartItems: updatedCart));
    _updateSummary();
  }

  void _updateSummary() {
    int totalAmount = 0;
    int totalDiscounts = 0;

    for (final item in state.cartItems) {
      final price = int.tryParse(item.price.replaceAll(',', '')) ?? 0;
      final oldPrice = item.oldPrice != null ? int.tryParse(item.oldPrice!.replaceAll(',', '')) : null;

      if (oldPrice != null && oldPrice > price) {
        totalAmount += oldPrice * item.quantity;
        totalDiscounts += (oldPrice - price) * item.quantity;
      } else {
        totalAmount += price * item.quantity;
      }
    }

    final payableAmount = totalAmount - totalDiscounts;
    final formatter = NumberFormat('#,###', 'en_US');

    emit(state.copyWith(
      totalAmount: formatter.format(totalAmount),
      totalDiscounts: formatter.format(totalDiscounts),
      payableAmount: formatter.format(payableAmount),
    ));
  }

  void showCart() {
    emit(state.copyWith(isCartVisible: true));
  }

  void hideCart() {
    emit(state.copyWith(isCartVisible: false));
  }

  void onCustomerIdChanged(String value) {
    bool isValid = isNationalIDValid(value);
    emit(state.copyWith(
      customerIdQuery: value,
      isNationalIdValid: isValid,
    ));
  }

  void searchCustomer() {
    if (state.customerIdQuery.isEmpty) return;
    emit(state.copyWith(customerSearchLoading: true));

    _customerRepo
        .getCustomers(nationalId: state.customerIdQuery)
        .then((response) {
          if (response.results.isNotEmpty) {
            final dto = response.results.first;
            final info = CustomerInfoModel(
              id: dto.id,
              firstName: dto.firstName,
              lastName: dto.lastName,
              nationalId: dto.nationalId,
              phoneNumber: dto.mobile,
              postalCode: dto.postalCode,
              address: dto.address,
            );
            emit(state.copyWith(
              customerSearchLoading: false,
              customerInfo: info,
              isExistingCustomer: true,
            ));
          } else {
            emit(state.copyWith(
              customerSearchLoading: false,
              customerInfo: CustomerInfoModel(
                firstName: '',
                lastName: '',
                nationalId: state.customerIdQuery,
                phoneNumber: '',
                postalCode: '',
                address: '',
              ),
              isExistingCustomer: false,
            ));
          }
        })
        .catchError((e) {
          emit(state.copyWith(
            customerSearchLoading: false,
            status: PreInvoiceRequestStatus.error,
            errorMessage: 'خطا در جستجوی مشتری',
          ));
        });
  }

  void onCustomerFieldChanged(String field, dynamic value) {
    if (state.customerInfo == null) return;
    var updated = state.customerInfo!;

    switch (field) {
      case 'firstName': updated = updated.copyWith(firstName: value); break;
      case 'lastName': updated = updated.copyWith(lastName: value); break;
      case 'nationalId': updated = updated.copyWith(nationalId: value); break;
      case 'phoneNumber': updated = updated.copyWith(phoneNumber: value); break;
      case 'postalCode': updated = updated.copyWith(postalCode: value); break;
      case 'address': updated = updated.copyWith(address: value); break;
      case 'isOrderSentToCustomerAddress': updated = updated.copyWith(isOrderSentToCustomerAddress: value); break;
    }
    emit(state.copyWith(customerInfo: updated));
  }

  Future<void> pickMandatoryDoc(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(context, isMultiSelection: false);
    if (result != null && result.isNotEmpty) {
      emit(state.copyWith(mandatoryDocPath: result.first.file.path));
    }
  }

  Future<void> pickOptionalDoc(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(context, isMultiSelection: true);
    if (result != null && result.isNotEmpty) {
      final updatedPaths = List<String>.from(state.optionalDocPaths)
        ..addAll(result.map((m) => m.file.path));
      emit(state.copyWith(optionalDocPaths: updatedPaths));
    }
  }

  void removeMandatoryDoc() {
    emit(state.copyWith(mandatoryDocPath: null));
  }

  void removeOptionalDoc(int index) {
    final updatedPaths = List<String>.from(state.optionalDocPaths)..removeAt(index);
    emit(state.copyWith(optionalDocPaths: updatedPaths));
  }

  void submitPreInvoice() {}
  void submitAndClear() {}

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

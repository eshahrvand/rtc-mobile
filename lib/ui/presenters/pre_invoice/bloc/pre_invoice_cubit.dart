import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../config/config.dart';
import '../../../../config/regex_national_number_validator.dart';
import '../../../../config/postal_code_validator.dart';
import '../../../../core/models/pre_invoice_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../repository/customers/customers_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../repository/media/media_repository.dart';
import '../../../../data_source/remote/orders/model/order_dto_model.dart';
import '../../../../data_source/remote/catalog/model/product_dto_model.dart';
import '../../../../data_source/remote/customers/model/customer_dto_model.dart';
import '../../../../core/utils/network_helper.dart';
import '../../media_picker/media_picker.dart';
import 'pre_invoice_state.dart';

class PreInvoiceCubit extends Cubit<PreInvoiceState> {
  final _plansRepo = sl<PlansRepository>();
  final _productRepo = sl<ProductRepository>();
  final _customerRepo = sl<CustomersRepository>();
  final _mediaRepo = sl<MediaRepository>();
  final _ordersRepo = sl<OrdersRepository>();
  final ImagePicker _picker = ImagePicker();
  Timer? _debounce;

  PreInvoiceCubit() : super(const PreInvoiceState());

  // ─── Setup & Navigation ────────────────────────────────────────────

  void init() {
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));

    _plansRepo
        .getSubPlans()
        .then<void>((response) {
          final plans = response.results.map(_mapToCreditPlanModel).toList();

          final chips = [
            PreInvoiceChipModel(
              id: 1,
              label: S.current.category,
              opensBottomSheet: true,
            ),
            PreInvoiceChipModel(
              id: 2,
              label: S.current.plan,
              opensBottomSheet: true,
            ),
            PreInvoiceChipModel(id: 3, label: S.current.onlyAvailableProducts),
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
          _handleError(e);
          return null;
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
    if (step == PreInvoiceStep.review && state.mandatoryDocPath != null) {
      _uploadDocuments();
      return;
    }
    emit(state.copyWith(currentStep: step, isEditMode: false));
  }

  void enterEditMode(PreInvoiceStep step) {
    emit(state.copyWith(currentStep: step, isEditMode: true));
  }

  void exitEditMode() {
    emit(state.copyWith(currentStep: PreInvoiceStep.review, isEditMode: false));
  }

  // ─── Step 2 — Products ─────────────────────────────────────────────

  void _loadProducts() {
    if (state.selectedCreditPlanId == null) return;
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));

    _productRepo
        .getProducts(
          subPlanId: state.selectedCreditPlanId!,
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
          categoryId: state.selectedCategoryId,
          inStock: state.showAvailableOnly ? true : null,
          ordering: state.selectedSortOrder,
        )
        .then((response) {
          final products = response.results.map(_mapProductDtoToModel).toList();
          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.success,
              allProducts: products,
              filteredProducts: products,
            ),
          );
        })
        .catchError((e) {
          _handleError(e);
          return null;
        });
  }

  void onCreditPlanSelected(String id) {
    if (state.selectedCreditPlanId != id) {
      emit(state.copyWith(selectedCreditPlanId: id, cartItems: []));
      _updateSummary();
    }
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

  void onSortSelected(String? ordering) {
    emit(state.copyWith(selectedSortOrder: ordering));
    _loadProducts();
  }

  void onChipSelected(int index) {
    emit(state.copyWith(selectedChipIndex: index));
  }

  void toggleShowAvailableOnly() {
    emit(state.copyWith(showAvailableOnly: !state.showAvailableOnly));
    _loadProducts();
  }

  // ─── Step 2 — Cart Operations ──────────────────────────────────────

  void addToCart(PreInvoiceProductModel product) {
    final inventoryCount = int.tryParse(product.inventory) ?? 0;
    final existingIndex = state.cartItems.indexWhere(
      (item) => item.productId == product.id,
    );
    final updatedCart = List<CartItemModel>.from(state.cartItems);

    if (existingIndex != -1) {
      final existingItem = updatedCart[existingIndex];
      if (existingItem.quantity >= inventoryCount) {
        emit(state.copyWith(status: PreInvoiceRequestStatus.initial));
        emit(
          state.copyWith(
            status: PreInvoiceRequestStatus.stockLimitReached,
            errorMessage: S.current.stockLimitError,
          ),
        );
        return;
      }
      updatedCart[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      if (inventoryCount <= 0) {
        emit(state.copyWith(status: PreInvoiceRequestStatus.initial));
        emit(
          state.copyWith(
            status: PreInvoiceRequestStatus.stockLimitReached,
            errorMessage: S.current.outOfStockError,
          ),
        );
        return;
      }
      updatedCart.add(
        CartItemModel(
          productId: product.id,
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          oldPrice: product.oldPrice,
          discount: product.discount,
          quantity: 1,
        ),
      );
    }
    emit(state.copyWith(cartItems: updatedCart));
    _updateSummary();
  }

  void increaseQuantity(String productId) {
    final updatedCart = List<CartItemModel>.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      // Find product in allProducts to check inventory
      final product = state.allProducts.firstWhere(
        (p) => p.id == productId,
        orElse: () => PreInvoiceProductModel(
          id: '',
          name: '',
          imageUrl: '',
          price: '',
          inventory: '0',
        ),
      );
      final inventoryCount = int.tryParse(product.inventory) ?? 0;

      if (updatedCart[index].quantity >= inventoryCount) {
        emit(state.copyWith(status: PreInvoiceRequestStatus.initial));
        emit(
          state.copyWith(
            status: PreInvoiceRequestStatus.stockLimitReached,
            errorMessage: S.current.stockLimitError,
          ),
        );
        return;
      }

      updatedCart[index] = updatedCart[index].copyWith(
        quantity: updatedCart[index].quantity + 1,
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
        updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity - 1,
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

  void showCart() {
    emit(state.copyWith(isCartVisible: true));
  }

  void hideCart() {
    emit(state.copyWith(isCartVisible: false));
  }

  // ─── Step 3 — Customer Info ────────────────────────────────────────

  void onCustomerIdChanged(String value) {
    bool isValid = isNationalIDValid(value);
    emit(
      state.copyWith(
        customerIdQuery: value,
        isNationalIdValid: isValid,
        customerInfo: null,
      ),
    );
  }

  void searchCustomer() {
    if (state.customerIdQuery.isEmpty) return;
    emit(
      state.copyWith(
        customerSearchLoading: true,
        status: PreInvoiceRequestStatus.initial,
      ),
    );

    _customerRepo
        .getCustomerByNationalId(state.customerIdQuery)
        .then((dto) {
          final info = CustomerInfoModel(
            id: dto.id,
            firstName: dto.firstName,
            lastName: dto.lastName,
            nationalId: dto.nationalId,
            phoneNumber: dto.mobile,
            postalCode: dto.postalCode,
            address: dto.address,
          );
          emit(
            state.copyWith(
              customerSearchLoading: false,
              customerInfo: info,
              originalCustomerInfo: info,
              isExistingCustomer: true,
            ),
          );
        })
        .catchError((e) {
          if (isClosed) return;

          NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
            if (isClosed) return;

            if (networkMessage != null) {
              _handleError(e);
              emit(state.copyWith(customerSearchLoading: false));
              return;
            }

            bool isNotFound = false;
            if (e is DioException) {
              if (e.response?.statusCode == 404) {
                isNotFound = true;
              }
            }

            if (isNotFound) {
              emit(
                state.copyWith(
                  customerSearchLoading: false,
                  customerInfo: CustomerInfoModel(
                    firstName: '',
                    lastName: '',
                    nationalId: state.customerIdQuery,
                    phoneNumber: '',
                    postalCode: '',
                    address: '',
                  ),
                  originalCustomerInfo: null,
                  isExistingCustomer: false,
                ),
              );
            } else {
              _handleError(e);
              emit(state.copyWith(customerSearchLoading: false));
            }
          });
        });
  }

  void onCustomerFieldChanged(String field, dynamic value) {
    if (state.customerInfo == null) return;
    var updated = state.customerInfo!;

    switch (field) {
      case 'firstName':
        updated = updated.copyWith(firstName: value);
        break;
      case 'lastName':
        updated = updated.copyWith(lastName: value);
        break;
      case 'nationalId':
        updated = updated.copyWith(nationalId: value);
        break;
      case 'phoneNumber':
        updated = updated.copyWith(phoneNumber: value);
        final isPhoneValid =
            value.isEmpty || RegExp(r'^09\d{9}$').hasMatch(value);
        emit(
          state.copyWith(
            customerInfo: updated,
            isPhoneNumberValid: isPhoneValid,
          ),
        );
        return;
      case 'postalCode':
        updated = updated.copyWith(postalCode: value);
        final isPostalValid = validatePostalCode(value);
        emit(
          state.copyWith(
            customerInfo: updated,
            isPostalCodeValid: isPostalValid,
          ),
        );
        return;
      case 'address':
        updated = updated.copyWith(address: value);
        break;
      case 'isOrderSentToCustomerAddress':
        updated = updated.copyWith(isOrderSentToCustomerAddress: value);
        break;
    }
    emit(state.copyWith(customerInfo: updated));
  }

  void _submitCustomerInfo() {
    final info = state.customerInfo!;
    final original = state.originalCustomerInfo;

    // Check if data has actually changed
    final hasChanged =
        original == null ||
        info.firstName != original.firstName ||
        info.lastName != original.lastName ||
        info.nationalId != original.nationalId ||
        info.phoneNumber != original.phoneNumber ||
        info.postalCode != original.postalCode ||
        info.address != original.address;

    if (!hasChanged) {
      emit(
        state.copyWith(
          currentStep: PreInvoiceStep.documents,
          isEditMode: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: PreInvoiceRequestStatus.loading,
        isSubmittingCustomerInfo: true,
      ),
    );

    final body = state.isExistingCustomer
        ? {
            'mobile': info.phoneNumber,
            'address': info.address,
            'postal_code': info.postalCode,
          }
        : _buildCustomerRequestBody(info);

    Future<CustomerDtoModel> request;

    if (state.isExistingCustomer) {
      request = _customerRepo.updateCustomer(info.nationalId, body);
    } else {
      request = _customerRepo.createCustomer(body);
    }

    request
        .then((response) {
          final updatedInfo = info.copyWith(id: response.id);
          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.success,
              customerInfo: updatedInfo,
              originalCustomerInfo: updatedInfo,
              isExistingCustomer: true,
              currentStep: PreInvoiceStep.documents,
              isEditMode: false,
              isSubmittingCustomerInfo: false,
            ),
          );
        })
        .catchError((e) {
          _handleError(e, prefix: S.current.customerInfoSubmitError);
          return null;
        });
  }

  // ─── Step 4 — Documents ────────────────────────────────────────────

  Future<void> pickMandatoryDoc(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(
      context,
      isMultiSelection: false,
      showCameraOverlay: true,
    );
    if (result != null && result.isNotEmpty) {
      emit(state.copyWith(mandatoryDocPath: result.first.file.path));
    }
  }

  Future<void> pickOptionalDoc(dynamic context) async {
    if (state.optionalDocPaths.length >= 5) {
      emit(
        state.copyWith(
          status: PreInvoiceRequestStatus.error,
          errorMessage: 'حداکثر ۵ تصویر اختیاری مجاز است',
        ),
      );
      return;
    }
    final result = await MediaPickerBottomSheet.show(
      context,
      isMultiSelection: true,
      showCameraOverlay: false,
    );
    if (result != null && result.isNotEmpty) {
      final availableSlots = 5 - state.optionalDocPaths.length;
      final newPaths = result
          .take(availableSlots)
          .map((m) => m.file.path)
          .toList();

      final updatedPaths = List<String>.from(state.optionalDocPaths)
        ..addAll(newPaths);
      emit(state.copyWith(optionalDocPaths: updatedPaths));

      if (result.length > availableSlots) {
        emit(
          state.copyWith(
            status: PreInvoiceRequestStatus.error,
            errorMessage:
                'فقط $availableSlots تصویر دیگر اضافه شد (حداکثر ۵ عدد)',
          ),
        );
      }
    }
  }

  void removeMandatoryDoc() {
    emit(state.copyWith(mandatoryDocPath: null));
  }

  void removeOptionalDoc(int index) {
    final updatedPaths = List<String>.from(state.optionalDocPaths)
      ..removeAt(index);
    emit(state.copyWith(optionalDocPaths: updatedPaths));
  }

  void _uploadDocuments() {
    emit(
      state.copyWith(
        status: PreInvoiceRequestStatus.loading,
        isUploadingDocuments: true,
      ),
    );

    final mandatoryFile = File(state.mandatoryDocPath!);
    final uploadTasks = <Future<String>>[];

    // Upload mandatory
    uploadTasks.add(
      _mediaRepo.uploadOrderDocument(mandatoryFile).then((m) => m.id),
    );

    // Upload optionals
    for (final path in state.optionalDocPaths) {
      uploadTasks.add(
        _mediaRepo.uploadOrderDocument(File(path)).then((m) => m.id),
      );
    }

    Future.wait(uploadTasks)
        .then((ids) {
          emit(
            state.copyWith(
              status: PreInvoiceRequestStatus.success,
              mandatoryDocId: ids.first,
              optionalDocIds: ids.skip(1).toList(),
              currentStep: PreInvoiceStep.review,
              isEditMode: false,
              isUploadingDocuments: false,
            ),
          );
        })
        .catchError((e) {
          _handleError(e, prefix: S.current.documentUploadError);
          return null;
        });
  }

  // ─── Step 5 — Submit Pre-Invoice ───────────────────────────────────

  void submitPreInvoice() {
    _createOrder(false);
  }

  void submitAndClear() {
    _createOrder(true);
  }

  void _createOrder(bool shouldClear) {
    if (state.customerInfo == null || state.selectedCreditPlanId == null) {
      return;
    }

    emit(
      state.copyWith(
        status: PreInvoiceRequestStatus.loading,
        isSubmittingPreInvoice: !shouldClear,
        isSubmittingAndClearing: shouldClear,
      ),
    );

    final request = OrderCreateRequest(
      customerId: state.customerInfo!.id!,
      subPlanId: state.selectedCreditPlanId!,
      lines: _buildOrderLines(),
      documents: _buildOrderDocuments(),
      deliveryToAgent: true,
    );

    _ordersRepo
        .createOrder(request)
        .then((order) {
          emit(
            state.copyWith(
              status: shouldClear
                  ? PreInvoiceRequestStatus.submittedAndCleared
                  : PreInvoiceRequestStatus.submitted,
              createdOrderId: order.id,
              isSubmittingPreInvoice: false,
              isSubmittingAndClearing: false,
            ),
          );
        })
        .catchError((e) {
          _handleError(e, prefix: S.current.preInvoiceSubmitError);
          return null;
        });
  }

  // ─── Private Helpers ───────────────────────────────────────────────

  CreditPlanItemModel _mapToCreditPlanModel(dynamic dto) {
    return CreditPlanItemModel(
      id: dto.id,
      logo: dto.creditPlan.image?.file ?? 'assets/images/wallet.svg',
      providerName: dto.creditPlan.name,
      planName: dto.name,
      validityDuration: dto.creditPlan.validity_window_days.toString(),
    );
  }

  PreInvoiceProductModel _mapProductDtoToModel(ProductDtoModel dto) {
    final formatter = NumberFormat('#,###', 'en_US');
    final planPrice = dto.planPrice ?? 0;

    // Calculate old price if discount is present but oldPrice is null
    num? finalOldPrice = dto.oldPrice;

    if (finalOldPrice == null &&
        dto.discountPct != null &&
        dto.discountPct! > 0) {
      // Calculate without manual rounding
      finalOldPrice = planPrice / (1 - (dto.discountPct! / 100));
    }

    // Use basePrice as final fallback
    finalOldPrice ??= dto.basePrice;

    return PreInvoiceProductModel(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.featuredImage?.file ?? '$baseImage/frame1.png',
      price: formatter.format(planPrice),
      oldPrice: finalOldPrice != null ? formatter.format(finalOldPrice) : null,
      discount: dto.discountPct != null && dto.discountPct! > 0
          ? '${dto.discountPct}%'
          : null,
      inventory: dto.stockQty.toString(),
      isAvailable: dto.stockQty > 0,
    );
  }

  Map<String, dynamic> _buildCustomerRequestBody(CustomerInfoModel info) {
    return {
      'first_name': info.firstName,
      'last_name': info.lastName,
      'national_id': info.nationalId,
      'mobile': info.phoneNumber,
      'postal_code': info.postalCode,
      'address': info.address,
    };
  }

  void _updateSummary() {
    int totalAmount = 0;
    int totalDiscounts = 0;
    int totalQuantity = 0;

    for (final item in state.cartItems) {
      totalQuantity += item.quantity;
      final currentPrice = int.tryParse(item.price.replaceAll(',', '')) ?? 0;
      final basePriceStr = item.oldPrice ?? item.price;
      final basePrice =
          int.tryParse(basePriceStr.replaceAll(',', '')) ?? currentPrice;

      final itemDiscount = (basePrice > currentPrice)
          ? (basePrice - currentPrice)
          : 0;

      totalAmount += basePrice * item.quantity;
      totalDiscounts += itemDiscount * item.quantity;
    }

    final payableAmount = totalAmount - totalDiscounts;
    final formatter = NumberFormat('#,###', 'en_US');

    emit(
      state.copyWith(
        totalAmount: formatter.format(totalAmount),
        totalDiscounts: formatter.format(totalDiscounts),
        payableAmount: formatter.format(payableAmount),
        totalQuantity: totalQuantity,
      ),
    );
  }

  List<OrderLineRequest> _buildOrderLines() {
    return state.cartItems.map((item) {
      return OrderLineRequest(
        productId: item.productId,
        quantity: item.quantity,
      );
    }).toList();
  }

  List<OrderDocumentRequest> _buildOrderDocuments() {
    final documents = <OrderDocumentRequest>[];
    if (state.mandatoryDocId != null) {
      documents.add(
        OrderDocumentRequest(
          documentType: 'national_id_front',
          fileId: state.mandatoryDocId!,
        ),
      );
    }
    for (final fileId in state.optionalDocIds) {
      documents.add(
        OrderDocumentRequest(documentType: 'supporting', fileId: fileId),
      );
    }
    return documents;
  }

  void _handleError(Object e, {String prefix = ''}) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then<void>((networkMessage) {
      if (isClosed) return;

      final finalMessage =
          networkMessage ??
          (prefix.isEmpty ? e.toString() : '$prefix: ${e.toString()}');

      emit(state.copyWith(status: PreInvoiceRequestStatus.initial));

      emit(
        state.copyWith(
          status: PreInvoiceRequestStatus.error,
          errorMessage: finalMessage,
          isUploadingDocuments: false,
          isSubmittingCustomerInfo: false,
          isSubmittingPreInvoice: false,
          isSubmittingAndClearing: false,
          customerSearchLoading: false,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

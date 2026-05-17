import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/config.dart';
import '../../../../data/models/pre_invoice_model.dart';
import 'pre_invoice_state.dart';

class PreInvoiceCubit extends Cubit<PreInvoiceState> {
  PreInvoiceCubit() : super(const PreInvoiceState());

  void init() {
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));

    // Simulate loading credit plans and products
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      final mockPlans = [
        CreditPlanItemModel(
          id: '1',
          logo: 'assets/images/snapp.png',
          providerName: 'اسنپ پی',
          planName: 'طرح ۶ ماهه',
          validityDuration: '۴۸ ساعت',
        ),
        CreditPlanItemModel(
          id: '2',
          logo: 'assets/images/tejarat.png',
          providerName: 'بانک تجارت',
          planName: 'طرح ۶ ماهه',
          validityDuration: '۴۸ ساعت',
        ),
        CreditPlanItemModel(
          id: '3',
          logo: 'assets/images/tara.png',
          providerName: 'تارا',
          planName: 'طرح ۶ ماهه',
          validityDuration: '۴۸ ساعت',
        ),
        CreditPlanItemModel(
          id: '4',
          logo: 'assets/images/melli.png',
          providerName: 'بانک ملی',
          planName: 'طرح ۶ ماهه',
          validityDuration: '۴۸ ساعت',
        ),
      ];

      final mockProducts = [
        PreInvoiceProductModel(
          id: '1',
          name: 'ماکروویو ۵۵ اینچ RTC مدل Smart TV 4K',
          imageUrl: '$baseImage/frame1.png',
          price: '۱۴,۴۹۰,۰۰۰',
          oldPrice: '۱۶,۱۰۰,۰۰۰',
          discount: '۲۰٪',
          inventory: '۸',
        ),
        PreInvoiceProductModel(
          id: '2',
          name: 'یخچال اسنوا ۵۵ اینچ RTC مدل Smart TV 4K',
          imageUrl: '$baseImage/frame2.png',
          price: '۱۴,۴۹۰,۰۰۰',
          inventory: '۲',
        ),
        PreInvoiceProductModel(
          id: '3',
          name: 'قهوه ساز ۵۵ اینچ RTC مدل Smart TV 4K',
          imageUrl: '$baseImage/frame3.png',
          price: '۱۴,۴۹۰,۰۰۰',
          inventory: '۰',
          isAvailable: false,
        ),
        PreInvoiceProductModel(
          id: '4',
          name: 'کتری برقی آر تی سی مدل Smart 4K',
          imageUrl: '$baseImage/frame4.png',
          price: '۱۴,۴۹۰,۰۰۰',
          oldPrice: '۱۶,۱۰۰,۰۰۰',
          discount: '۲۰٪',
          inventory: '۲',
        ),
      ];

      final mockChips = [
        PreInvoiceChipModel(id: 1, label: 'دسته بندی', opensBottomSheet: true),
        PreInvoiceChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
        PreInvoiceChipModel(id: 3, label: 'نمایش کالاهای موجود'),
      ];

      emit(state.copyWith(
        status: PreInvoiceRequestStatus.success,
        creditPlans: mockPlans,
        allProducts: mockProducts,
        filteredProducts: mockProducts,
        filterChips: mockChips,
      ));
    }).catchError((e) {
      emit(state.copyWith(
        status: PreInvoiceRequestStatus.error,
        errorMessage: e.toString(),
      ));
    });
  }

  void goToStep(PreInvoiceStep step) {
    emit(state.copyWith(currentStep: step));
  }

  void onCreditPlanSelected(String id) {
    emit(state.copyWith(selectedCreditPlanId: id));
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    emit(state.copyWith(
      isSearchActive: false,
      searchQuery: '',
      filteredProducts: state.allProducts,
    ));
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _filterProducts();
  }

  void onChipSelected(int index) {
    emit(state.copyWith(selectedChipIndex: index));
    _filterProducts();
  }

  void toggleShowAvailableOnly() {
    emit(state.copyWith(showAvailableOnly: !state.showAvailableOnly));
    _filterProducts();
  }

  void _filterProducts() {
    var filtered = state.allProducts;
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) => p.name.contains(state.searchQuery))
          .toList();
    }

    if (state.showAvailableOnly) {
      filtered = filtered.where((p) => p.isAvailable).toList();
    }

    // Add chip filtering logic here if needed
    emit(state.copyWith(filteredProducts: filtered));
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
        discount: existingItem.discount,
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedCart.add(CartItemModel(
        productId: product.id,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
        discount: product.discount,
        quantity: 1,
      ));
    }
    emit(state.copyWith(cartItems: updatedCart));
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
        discount: item.discount,
        quantity: item.quantity + 1,
      );
      emit(state.copyWith(cartItems: updatedCart));
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
          discount: existingItem.discount,
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedCart.removeAt(index);
      }
    }
    emit(state.copyWith(cartItems: updatedCart));
  }

  void deleteFromCart(String productId) {
    final updatedCart = List<CartItemModel>.from(state.cartItems)
      ..removeWhere((item) => item.productId == productId);
    emit(state.copyWith(cartItems: updatedCart));
  }

  void showCart() {
    emit(state.copyWith(isCartVisible: true));
  }

  void hideCart() {
    emit(state.copyWith(isCartVisible: false));
  }

  void onCustomerIdChanged(String value) {
    emit(state.copyWith(customerIdQuery: value));
  }

  void searchCustomer() {
    if (state.customerIdQuery.isEmpty) return;

    emit(state.copyWith(customerSearchLoading: true));

    Future.delayed(const Duration(seconds: 1)).then((_) {
      final mockCustomer = CustomerInfoModel(
        firstName: 'سامان',
        lastName: 'راد',
        nationalId: state.customerIdQuery,
        phoneNumber: '۰۹۱۲۶۰۷۷۴۵۶',
        postalCode: '۱۹۳۳۹۴۳۱۱۱',
        address: 'تجریش، ابتدای شریعتی، کوچه پروین، پلاک ۲۸، زنگ ۳',
      );
      emit(state.copyWith(
        customerSearchLoading: false,
        customerInfo: mockCustomer,
      ));
    }).catchError((e) {
      emit(state.copyWith(
        customerSearchLoading: false,
        status: PreInvoiceRequestStatus.error,
        errorMessage: 'مشتری یافت نشد',
      ));
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
        break;
      case 'postalCode':
        updated = updated.copyWith(postalCode: value);
        break;
      case 'address':
        updated = updated.copyWith(address: value);
        break;
      case 'isOrderSentToCustomerAddress':
        updated = updated.copyWith(isOrderSentToCustomerAddress: value);
        break;
    }
    emit(state.copyWith(customerInfo: updated));
  }

  void pickMandatoryDoc() {
    // Gallery picker logic would go here
    // Simulating selection
    emit(state.copyWith(mandatoryDocPath: 'path/to/mandatory_doc.jpg'));
  }

  void pickOptionalDoc() {
    // Simulating selection
    emit(state.copyWith(optionalDocPath: 'path/to/optional_doc.jpg'));
  }

  void removeMandatoryDoc() {
    emit(state.copyWith(mandatoryDocPath: null));
  }

  void removeOptionalDoc() {
    emit(state.copyWith(optionalDocPath: null));
  }

  void submitPreInvoice() {
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));
    Future.delayed(const Duration(seconds: 1)).then((_) {
      emit(state.copyWith(status: PreInvoiceRequestStatus.submitted));
    }).catchError((e) {
      emit(state.copyWith(
        status: PreInvoiceRequestStatus.error,
        errorMessage: e.toString(),
      ));
    });
  }

  void submitAndClear() {
    emit(state.copyWith(status: PreInvoiceRequestStatus.loading));
    Future.delayed(const Duration(seconds: 1)).then((_) {
      emit(state.copyWith(status: PreInvoiceRequestStatus.submittedAndCleared));
    }).catchError((e) {
      emit(state.copyWith(
        status: PreInvoiceRequestStatus.error,
        errorMessage: e.toString(),
      ));
    });
  }
}

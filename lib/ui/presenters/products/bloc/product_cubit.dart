import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import '../../../../../data/models/product_chip_model.dart';
import '../../../../../data/models/product_item_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  void init() {
    emit(state.copyWith(status: ProductRequestStatus.loading));

    // TODO: call sl<ProductRepository>().getChips()
    // TODO: call sl<ProductRepository>().getProducts()

    // Mock data based on screenshots
    final chips = [
      ProductChipModel(id: 1, label: 'دسته بندی', opensBottomSheet: true),
      ProductChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
      ProductChipModel(id: 3, label: 'فقط کالاهای موجود'),
    ];

    final products = [
      ProductItemModel(
        id: '1',
        name: 'یخچال ۵۵ فوت RTC مدل Smart TV 4K',
        imageUrl: '$baseImage/frame1.png',
        price: '۲۲,۴۹۰,۰۰۰',
        inventory: '۵',
      ),
      ProductItemModel(
        id: '2',
        name: 'ماکروویو RTC مدل Smart 4K',
        imageUrl: '$baseImage/frame2.png',
        price: '۱۴,۴۹۰,۰۰۰',
        oldPrice: '۱۶,۱۰۰,۰۰۰',
        inventory: '۸',
        discount: '۲۰٪',
      ),
      ProductItemModel(
        id: '3',
        name: 'ماکروویو RTC مدل Smart 4K',
        imageUrl: '$baseImage/frame2.png',
        price: '۱۴,۴۹۰,۰۰۰',
        oldPrice: '۱۶,۱۰۰,۰۰۰',
        inventory: '۸',
        discount: '۲۰٪',
      ),
      ProductItemModel(
        id: '4',
        name: 'اسپروساز دلونگی مدل 35554',
        imageUrl: '$baseImage/frame3.png',
        price: '۱۴,۴۹۰,۰۰۰',
        inventory: '۲',
      ),
      ProductItemModel(
        id: '5',
        name: 'هواپز NINJA PRO مدل RTC RTC366',
        imageUrl: '$baseImage/frame4.png',
        price: '۱۴,۴۹۰,۰۰۰',
        inventory: '۴',
      ),
      ProductItemModel(
        id: '6',
        name: 'هواپز NINJA PRO مدل RTC RTC66',
        imageUrl: '$baseImage/frame4.png',
        price: '۱۴,۴۹۰,۰۰۰',
        inventory: '۴',
      ),
    ];

    // Using Future.delayed to simulate API call and follow .then().catchError() pattern
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) {
          emit(
            state.copyWith(
              status: ProductRequestStatus.success,
              chips: chips,
              allProducts: products,
              filteredProducts: products,
            ),
          );
        })
        .catchError((Object e) {
          emit(
            state.copyWith(
              status: ProductRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    emit(
      state.copyWith(
        isSearchActive: false,
        searchQuery: '',
        filteredProducts: state.allProducts,
      ),
    );
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _filterProducts();
  }

  void onChipSelected(int index) {
    emit(state.copyWith(selectedChipIndex: index));
    _filterProducts();
  }

  void onChipTap(ProductChipModel chip) {
    final index = state.chips.indexOf(chip);
    if (index != -1) {
      onChipSelected(index);
    }
    // BottomSheet logic added later by developer
  }

  void _filterProducts() {
    List<ProductItemModel> filtered = state.allProducts;

    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (p) =>
                p.name.toLowerCase().contains(state.searchQuery.toLowerCase()),
          )
          .toList();
    }

    // In a real implementation, chip filtering logic would go here
    // For now, we just update the state
    emit(state.copyWith(filteredProducts: filtered));
  }
}

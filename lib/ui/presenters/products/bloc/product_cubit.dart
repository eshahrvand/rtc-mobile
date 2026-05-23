import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../../data/models/product_item_model.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../locator.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  final _productRepo = sl<ProductRepository>();

  void init({String? subPlanId}) {
    emit(state.copyWith(status: ProductRequestStatus.loading));

    // Mock chips based on screenshots
    final chips = [
      ProductChipModel(id: 1, label: 'دسته بندی', opensBottomSheet: true),
      ProductChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
      ProductChipModel(id: 3, label: 'فقط کالاهای موجود'),
    ];

    _productRepo.getProducts(
      subPlanId: subPlanId,
      search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
    ).then((response) {
      final products = response.results.map((dto) => ProductItemModel(
        id: dto.id,
        name: dto.name,
        imageUrl: dto.featuredImage?.file ?? '',
        price: subPlanId != null 
            ? dto.planPrice?.toString() ?? '۰' 
            : dto.basePrice?.toString() ?? '۰',
        oldPrice: subPlanId != null ? dto.basePrice?.toString() : null,
        inventory: dto.stockQty.toString(),
        discount: dto.discountPct != null ? '${dto.discountPct}٪' : null,
      )).toList();

      emit(state.copyWith(
        status: ProductRequestStatus.success,
        chips: chips,
        allProducts: products,
        filteredProducts: products,
      ));
    }).catchError((Object e) {
      emit(state.copyWith(
        status: ProductRequestStatus.error,
        errorMessage: e.toString(),
      ));
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

  void selectFilter(String id) {
    emit(state.copyWith(selectedFilterId: id));
    _filterProducts();
  }

  void clearFilter() {
    emit(state.copyWith(selectedFilterId: null));
    _filterProducts();
  }

  void onChipTap(ProductChipModel chip) {
    if (chip.opensBottomSheet) {
      emit(state.copyWith(activeFilterChip: chip));
    } else {
      final index = state.chips.indexOf(chip);
      if (index != -1) {
        onChipSelected(index);
      }
    }
  }

  void clearActiveFilterRequest() {
    emit(state.copyWith(activeFilterChip: null));
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

    if (state.selectedFilterId != null) {
      filtered = filtered
          .where((p) => p.id == state.selectedFilterId)
          .toList();
    }

    emit(state.copyWith(filteredProducts: filtered));
  }
}

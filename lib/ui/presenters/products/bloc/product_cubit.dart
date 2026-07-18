import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/filter_item.dart';
import '../../../../core/models/product_chip_model.dart';
import '../../../../core/models/product_item_model.dart';
import '../../../../config/errorhandler.dart';
import '../../../../generated/l10n.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../locator.dart';
import '../../../../data_source/remote/catalog/model/brand_dto_model.dart';
import '../../../../data_source/remote/catalog/model/product_dto_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  final _productRepo = sl<ProductRepository>();
  final _plansRepo = sl<PlansRepository>();
  Timer? _debounce;

  void init() {
    emit(state.copyWith(status: ProductRequestStatus.loading));

    final chips = _createInitialChips();

    Future.wait([
      _productRepo.getCategories(),
      _plansRepo.getSubPlans(),
      _productRepo.getBrands(),
    ])
        .then((results) {
          final categoriesResponse = results[0];
          final subPlansResponse = results[1];
          final brandsResponse = results[2];

          emit(
            state.copyWith(
              chips: chips,
              availableCategories: (categoriesResponse as dynamic).results,
              availableSubPlans: (subPlansResponse as dynamic).results,
              availableBrands: (brandsResponse as dynamic).results,
            ),
          );

          _fetchProducts();
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: ProductRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          return null;
        });
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    _debounce?.cancel();
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    _fetchProducts();
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (query.isEmpty) {
      _fetchProducts();
      return;
    }

    if (query.length < 2) return;

    _debounce = Timer(const Duration(seconds: 1), () {
      _fetchProducts();
    });
  }

  void selectCategory(String? categoryId) {
    if (state.selectedCategoryId == categoryId) return;

    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        selectedChipIndex: categoryId != null ? 0 : -1,
        currentPage: 1,
        hasMoreData: true,
      ),
    );
    _fetchProducts();
  }

  void selectBrand(String? brandId) {
    if (state.selectedBrandId == brandId) return;

    emit(
      state.copyWith(
        selectedBrandId: brandId,
        selectedChipIndex: brandId != null ? 1 : -1,
        currentPage: 1,
        hasMoreData: true,
      ),
    );
    _fetchProducts();
  }

  void selectSubPlan(String? subPlanId) {
    if (state.selectedSubPlanId == subPlanId) return;

    final subPlanName = subPlanId != null
        ? state.availableSubPlans.firstWhere((s) => s.id == subPlanId).name
        : null;

    emit(
      state.copyWith(
        selectedSubPlanId: subPlanId,
        selectedSubPlanName: subPlanName,
        selectedChipIndex: subPlanId != null ? 2 : -1,
        currentPage: 1,
        hasMoreData: true,
      ),
    );
    _fetchProducts();
  }

  void toggleOnlyAvailable() {
    final newValue = !state.isOnlyAvailable;
    emit(
      state.copyWith(
        isOnlyAvailable: newValue,
        selectedChipIndex: newValue ? 3 : -1,
        currentPage: 1,
        hasMoreData: true,
      ),
    );
    _fetchProducts();
  }

  void onChipTap(ProductChipModel chip) {
    if (chip.opensBottomSheet) {
      emit(state.copyWith(activeFilterChip: chip));
    } else if (chip.id == 3) {
      toggleOnlyAvailable();
    }
  }

  void onChipClose(ProductChipModel chip) {
    if (chip.id == 1) {
      selectCategory(null);
    } else if (chip.id == 4) {
      selectBrand(null);
    } else if (chip.id == 2) {
      selectSubPlan(null);
    } else if (chip.id == 3) {
      toggleOnlyAvailable();
    }
  }

  void clearActiveFilterRequest() {
    emit(state.copyWith(activeFilterChip: null));
  }

  void clearAllFilters() {
    _debounce?.cancel();
    emit(
      state.copyWith(
        searchQuery: '',
        isSearchActive: false,
        selectedCategoryId: null,
        selectedBrandId: null,
        selectedSubPlanId: null,
        selectedSubPlanName: null,
        isOnlyAvailable: false,
        selectedChipIndex: -1,
        currentPage: 1,
        hasMoreData: true,
      ),
    );
    _fetchProducts();
  }

  void fetchNextPage() {
    if (state.isPaginationLoading ||
        !state.hasMoreData ||
        state.status == ProductRequestStatus.loading) {
      return;
    }

    emit(state.copyWith(isPaginationLoading: true));

    final nextPage = state.currentPage + 1;

    _productRepo
        .getProducts(
          subPlanId: state.selectedSubPlanId,
          categoryId: state.selectedCategoryId,
          brandId: state.selectedBrandId,
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
          inStock: state.isOnlyAvailable ? true : null,
          page: nextPage,
        )
        .then((response) {
          final newProducts =
              response.results.map(_mapToProductItemModel).toList();

          final updatedProducts = [...state.allProducts, ...newProducts];

          emit(
            state.copyWith(
              isPaginationLoading: false,
              currentPage: nextPage,
              allProducts: updatedProducts,
              filteredProducts: updatedProducts,
              hasMoreData: response.next != null,
              totalCount: response.count,
            ),
          );
        })
        .catchError((e) {
          emit(state.copyWith(isPaginationLoading: false));
          return null;
        });
  }

  void _fetchProducts() {
    emit(state.copyWith(status: ProductRequestStatus.loading, currentPage: 1));

    _productRepo
        .getProducts(
          subPlanId: state.selectedSubPlanId,
          categoryId: state.selectedCategoryId,
          brandId: state.selectedBrandId,
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
          inStock: state.isOnlyAvailable ? true : null,
          page: 1,
        )
        .then((response) {
          final products = response.results.map(_mapToProductItemModel).toList();

          emit(
            state.copyWith(
              status: ProductRequestStatus.success,
              allProducts: products,
              filteredProducts: products,
              totalCount: response.count,
              hasMoreData: response.next != null,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: ProductRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          return null;
        });
  }

  List<ProductChipModel> _createInitialChips() {
    return [
      ProductChipModel(
        id: 1,
        label: S.current.category,
        opensBottomSheet: true,
      ),
      ProductChipModel(id: 4, label: S.current.brand, opensBottomSheet: true),
      ProductChipModel(id: 2, label: S.current.plan, opensBottomSheet: true),
      ProductChipModel(
        id: 3,
        label: S.current.onlyAvailableProducts,
        opensBottomSheet: false,
      ),
    ];
  }

  ProductItemModel _mapToProductItemModel(ProductDtoModel dto) {
    final formatter = NumberFormat('#,###', 'en_US');

    final currentPrice = state.selectedSubPlanId != null
        ? dto.planPrice ?? 0
        : dto.basePrice ?? 0;

    num? finalOldPrice = dto.oldPrice;

    if (finalOldPrice == null &&
        dto.discountPct != null &&
        dto.discountPct! > 0) {
      finalOldPrice = currentPrice / (1 - (dto.discountPct! / 100));
    }

    // fallback if still null and not applying plan price
    if (state.selectedSubPlanId == null) {
      finalOldPrice ??= dto.basePrice;
    }

    return ProductItemModel(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.featuredImage?.file ?? '',
      price: formatter.format(currentPrice),
      oldPrice: finalOldPrice != null ? formatter.format(finalOldPrice) : null,
      inventory: dto.stockQty.toString(),
      discount: dto.discountPct != null && dto.discountPct != 0
          ? '${dto.discountPct}٪'
          : null,
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

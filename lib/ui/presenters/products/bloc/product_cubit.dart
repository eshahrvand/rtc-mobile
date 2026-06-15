import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../../data/models/product_item_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../locator.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  final _productRepo = sl<ProductRepository>();
  final _plansRepo = sl<PlansRepository>();
  Timer? _debounce;

  void init() {
    emit(state.copyWith(status: ProductRequestStatus.loading));

    final chips = _createInitialChips();

    Future.wait([_productRepo.getCategories(), _plansRepo.getSubPlans()])
        .then((results) {
          final categoriesResponse = results[0];
          final subPlansResponse = results[1];

          emit(
            state.copyWith(
              chips: chips,
              availableCategories: (categoriesResponse as dynamic).results,
              availableSubPlans: (subPlansResponse as dynamic).results,
            ),
          );

          _fetchProducts();
        })
        .catchError(_handleError);
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
        selectedChipIndex: subPlanId != null ? 1 : -1,
      ),
    );
    _fetchProducts();
  }

  void toggleOnlyAvailable() {
    final newValue = !state.isOnlyAvailable;
    emit(
      state.copyWith(
        isOnlyAvailable: newValue,
        selectedChipIndex: newValue ? 2 : -1,
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
        selectedSubPlanId: null,
        selectedSubPlanName: null,
        isOnlyAvailable: false,
        selectedChipIndex: -1,
      ),
    );
    _fetchProducts();
  }

  void _fetchProducts() {
    emit(state.copyWith(status: ProductRequestStatus.loading));

    _productRepo
        .getProducts(
          subPlanId: state.selectedSubPlanId,
          categoryId: state.selectedCategoryId,
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
          inStock: state.isOnlyAvailable ? true : null,
        )
        .then((response) {
          final products = response.results
              .map(_mapToProductItemModel)
              .toList();

          emit(
            state.copyWith(
              status: ProductRequestStatus.success,
              allProducts: products,
              filteredProducts: products,
            ),
          );
        })
        .catchError(_handleError);
  }

  List<ProductChipModel> _createInitialChips() {
    return [
      ProductChipModel(id: 1, label: S.current.category, opensBottomSheet: true),
      ProductChipModel(id: 2, label: S.current.plan, opensBottomSheet: true),
      ProductChipModel(
        id: 3,
        label: S.current.onlyAvailableProducts,
        opensBottomSheet: false,
      ),
    ];
  }

  ProductItemModel _mapToProductItemModel(dynamic dto) {
    return ProductItemModel(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.featuredImage?.file ?? '',
      price: state.selectedSubPlanId != null
          ? dto.planPrice?.toString() ?? '۰'
          : dto.basePrice?.toString() ?? '۰',
      oldPrice: state.selectedSubPlanId != null
          ? dto.basePrice?.toString()
          : null,
      inventory: dto.stockQty.toString(),
      discount: dto.discountPct != null && dto.discountPct != 0
          ? '${dto.discountPct}٪'
          : null,
    );
  }

  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();

      emit(
        state.copyWith(
          status: ProductRequestStatus.error,
          errorMessage: finalMessage,
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

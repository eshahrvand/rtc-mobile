import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../../data/models/product_item_model.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../locator.dart';
import 'product_state.dart';

// ─── REFACTOR LOG ───────────────────────────────────────────────────
// [1] Extracted `_createInitialChips()` to simplify initialization logic.
// [2] Extracted `_mapToProductItemModel()` to isolate DTO mapping logic.
// [3] Extracted `_handleError()` to remove duplication in API error handling.
// [4] Reordered methods: Event handlers first, followed by private helpers.
// [5] Added inline documentation for search and filter logic.
// ────────────────────────────────────────────────────────────────────

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  final _productRepo = sl<ProductRepository>();
  final _plansRepo = sl<PlansRepository>();
  Timer? _debounce;

  // ─── Event Handlers ────────────────────────────────────────────────

  /// Initializes the products screen by loading categories, plans, and the initial product list.
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

  /// Activates the search mode in the UI.
  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  /// Deactivates search, clears the query, and refreshes the product list.
  void deactivateSearch() {
    _debounce?.cancel();
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    _fetchProducts();
  }

  /// Handles real-time search query changes with a 1-second debounce.
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

  /// Filters products by the selected category.
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

  /// Filters products by the selected credit plan.
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

  /// Toggles the "Only Available" stock filter.
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

  /// Generic handler for chip interactions.
  void onChipTap(ProductChipModel chip) {
    if (chip.opensBottomSheet) {
      emit(state.copyWith(activeFilterChip: chip));
    } else if (chip.id == 3) {
      toggleOnlyAvailable();
    }
  }

  /// Handles the removal of a specific filter via the chip "X" button.
  void onChipClose(ProductChipModel chip) {
    if (chip.id == 1) {
      selectCategory(null);
    } else if (chip.id == 2) {
      selectSubPlan(null);
    } else if (chip.id == 3) {
      toggleOnlyAvailable();
    }
  }

  /// Clears the request to open a filter bottom sheet.
  void clearActiveFilterRequest() {
    emit(state.copyWith(activeFilterChip: null));
  }

  /// Resets all search and filter parameters to their default state.
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

  // ─── Private Helpers ───────────────────────────────────────────────

  /// Fetches the product list from the repository using current filters.
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

  /// Defines the initial static filter chips.
  List<ProductChipModel> _createInitialChips() {
    return [
      ProductChipModel(id: 1, label: 'دسته بندی', opensBottomSheet: true),
      ProductChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
      ProductChipModel(
        id: 3,
        label: 'فقط کالاهای موجود',
        opensBottomSheet: false,
      ),
    ];
  }

  /// Maps a product DTO to the presentation model, handling plan-specific pricing.
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

  /// Centralized handler for repository errors.
  void _handleError(Object e) {
    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      emit(
        state.copyWith(
          status: ProductRequestStatus.error,
          errorMessage: networkMessage ?? e.toString(),
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

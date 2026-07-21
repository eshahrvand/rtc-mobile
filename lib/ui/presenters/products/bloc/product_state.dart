import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/models/filter_item.dart';
import '../../../../../data_source/remote/catalog/model/brand_dto_model.dart';
import '../../../../../data_source/remote/catalog/model/category_dto_model.dart';
import '../../../../../data_source/remote/plans/model/plan_dto_model.dart';
import '../../../../core/models/product_chip_model.dart';
import '../../../../core/models/product_item_model.dart';

part 'product_state.freezed.dart';

enum ProductRequestStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(ProductRequestStatus.initial) ProductRequestStatus status,
    @Default('') String errorMessage,

    // AppBar
    @Default(false) bool isSearchActive,
    @Default('') String searchQuery,

    // Choice Chips
    @Default([]) List<ProductChipModel> chips,
    @Default(-1) int selectedChipIndex, // -1 means no chip is selected by default
    String? selectedCategoryId,
    String? selectedBrandId,
    String? selectedSubPlanId,
    String? selectedSubPlanName,
    @Default(false) bool isOnlyAvailable,
    ProductChipModel? activeFilterChip,

    // Dynamic Filter Data
    @Default([]) List<CategoryDtoModel> availableCategories,
    @Default(1) int currentCategoryPage,
    @Default(false) bool hasMoreCategories,
    @Default(false) bool isCategoryPaginationLoading,

    @Default([]) List<SubPlanDtoModel> availableSubPlans,
    @Default(1) int currentSubPlanPage,
    @Default(false) bool hasMoreSubPlans,
    @Default(false) bool isSubPlanPaginationLoading,

    @Default([]) List<BrandDtoModel> availableBrands,
    @Default(1) int currentBrandPage,
    @Default(false) bool hasMoreBrands,
    @Default(false) bool isBrandPaginationLoading,

    // Product List
    @Default([]) List<ProductItemModel> allProducts,
    @Default([]) List<ProductItemModel> filteredProducts,

    // Pagination
    @Default(1) int currentPage,
    @Default(0) int totalCount,
    @Default(false) bool isPaginationLoading,
    @Default(true) bool hasMoreData,
  }) = _ProductState;
}

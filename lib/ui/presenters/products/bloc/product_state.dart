import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../data/models/product_chip_model.dart';
import '../../../../../data/models/product_item_model.dart';
import '../../../../../data_source/remote/catalog/model/category_dto_model.dart';
import '../../../../../data_source/remote/plans/model/plan_dto_model.dart';

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
    String? selectedSubPlanId,
    String? selectedSubPlanName,
    @Default(false) bool isOnlyAvailable,
    ProductChipModel? activeFilterChip,

    // Dynamic Filter Data
    @Default([]) List<CategoryDtoModel> availableCategories,
    @Default([]) List<SubPlanDtoModel> availableSubPlans,

    // Product List
    @Default([]) List<ProductItemModel> allProducts,
    @Default([]) List<ProductItemModel> filteredProducts,
  }) = _ProductState;
}

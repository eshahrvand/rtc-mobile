import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../data/models/product_chip_model.dart';
import '../../../../../data/models/product_item_model.dart';

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
    @Default(0) int selectedChipIndex,

    // Product List
    @Default([]) List<ProductItemModel> allProducts,
    @Default([]) List<ProductItemModel> filteredProducts,
  }) = _ProductState;
}

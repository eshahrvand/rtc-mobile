class FilterItemModel {
  final String id;
  final String title;

  const FilterItemModel({required this.id, required this.title});
}

class ProductChipModel {
  final int id;
  final String label;
  final bool opensBottomSheet;
  final List<FilterItemModel> filterItems;
  final String? selectedFilterId;

  const ProductChipModel({
    required this.id,
    required this.label,
    this.opensBottomSheet = false,
    this.filterItems = const [],
    this.selectedFilterId,
  });

  /// Returns the selected filter's title — used to show active state on chip.
  String? get selectedFilterTitle => selectedFilterId == null
      ? null
      : filterItems
      .where((f) => f.id == selectedFilterId)
      .map((f) => f.title)
      .firstOrNull;

  bool get hasActiveFilter => selectedFilterId != null;

  ProductChipModel copyWith({
    int? id,
    String? label,
    bool? opensBottomSheet,
    List<FilterItemModel>? filterItems,
    // Use a sentinel to allow explicit null (clearing the filter).
    Object? selectedFilterId = _sentinel,
  }) {
    return ProductChipModel(
      id: id ?? this.id,
      label: label ?? this.label,
      opensBottomSheet: opensBottomSheet ?? this.opensBottomSheet,
      filterItems: filterItems ?? this.filterItems,
      selectedFilterId: selectedFilterId == _sentinel
          ? this.selectedFilterId
          : selectedFilterId as String?,
    );
  }
}

// Sentinel object to distinguish "not provided" from explicit null.
const Object _sentinel = Object();
class ProductChipModel {
  final int id;
  final String label;
  final bool opensBottomSheet;
  final int? selectedCount;

  ProductChipModel({
    required this.id,
    required this.label,
    this.opensBottomSheet = false,
    this.selectedCount,
  });

  ProductChipModel copyWith({
    int? id,
    String? label,
    bool? opensBottomSheet,
    int? selectedCount,
  }) {
    return ProductChipModel(
      id: id ?? this.id,
      label: label ?? this.label,
      opensBottomSheet: opensBottomSheet ?? this.opensBottomSheet,
      selectedCount: selectedCount ?? this.selectedCount,
    );
  }
}

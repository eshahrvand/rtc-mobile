class ProductChipModel {
  final int id;
  final String label;
  final bool opensBottomSheet;

  ProductChipModel({
    required this.id,
    required this.label,
    this.opensBottomSheet = false,
  });
}

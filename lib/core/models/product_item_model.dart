class ProductItemModel {
  final String id;
  final String name;
  final String? subtitle;
  final String imageUrl;
  final String price;
  final String? oldPrice;
  final String inventory;
  final String? discount;

  ProductItemModel({
    required this.id,
    required this.name,
    this.subtitle,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.inventory,
    this.discount,
  });
}

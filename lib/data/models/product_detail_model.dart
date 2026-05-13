class ProductDetailModel {
  final String id;
  final String name;
  final String price;
  final String? oldPrice;
  final String? discountPercent;
  final List<String> imageUrls;
  final List<ProductBadgeModel> badges;
  final List<ProductSpecModel> specs;
  final String description;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    this.discountPercent,
    required this.imageUrls,
    required this.badges,
    required this.specs,
    required this.description,
  });
}

class ProductBadgeModel {
  final String label;
  final String value;
  final String? iconPath;

  ProductBadgeModel({
    required this.label,
    required this.value,
    this.iconPath,
  });
}

class ProductSpecModel {
  final String key;
  final String value;

  ProductSpecModel({
    required this.key,
    required this.value,
  });
}

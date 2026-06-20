class QuickAccessItemModel {
  final String title;
  final String value;
  final String currency;
  final String iconPath;
  final String? percentage;

  QuickAccessItemModel({
    required this.title,
    required this.value,
    required this.currency,
    required this.iconPath,
    this.percentage,
  });
}

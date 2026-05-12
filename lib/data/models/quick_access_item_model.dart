class QuickAccessItemModel {
  final String title;
  final String iconPath;
  final String? badgeCount;

  QuickAccessItemModel({
    required this.title,
    required this.iconPath,
    this.badgeCount,
  });
}

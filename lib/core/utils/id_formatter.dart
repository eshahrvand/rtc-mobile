class IdFormatter {
  static String formatDisplayId(String id) {
    if (id.contains('-')) {
      return id.split('-').first.toUpperCase();
    }
    return id.substring(0, id.length > 8 ? 8 : id.length).toUpperCase();
  }
}

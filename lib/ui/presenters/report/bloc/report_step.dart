enum ReportStep {
  sales,
  plan,
  category,
  products,
}

extension ReportStepExtension on ReportStep {
  String get title {
    switch (this) {
      case ReportStep.sales:
        return 'گزارش فروش';
      case ReportStep.plan:
        return 'گزارش طرح‌ها';
      case ReportStep.category:
        return 'گزارش دسته‌بندی کالاها';
      case ReportStep.products:
        return 'گزارش محصولات';
    }
  }
}

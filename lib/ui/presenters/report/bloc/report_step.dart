import '../../../../generated/l10n.dart';

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
        return S.current.salesReportTitle;
      case ReportStep.plan:
        return S.current.planReportTitle;
      case ReportStep.category:
        return S.current.categoryReportTitle;
      case ReportStep.products:
        return S.current.productReportTitle;
    }
  }
}

class CommissionReportEntry {
  final String id;
  final String orderNumber;
  final String customerName;
  final String planName;
  final double saleAmount;
  final DateTime? disbursedAt;
  final DateTime? approvedAt;

  const CommissionReportEntry({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.planName,
    required this.saleAmount,
    required this.disbursedAt,
    required this.approvedAt,
  });
}

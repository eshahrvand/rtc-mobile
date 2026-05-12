class OrderItemModel {
  final String orderId;
  final String customerName;
  final String date;
  final String status;
  final String amount;

  OrderItemModel({
    required this.orderId,
    required this.customerName,
    required this.date,
    required this.status,
    required this.amount,
  });
}

class CustomerItemModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String city;

  CustomerItemModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.city,
  });
}

class CustomerDetailModel {
  final String id;
  final String name;
  final String nationalCode;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final List<CustomerOrderItemModel> orders;

  CustomerDetailModel({
    required this.id,
    required this.name,
    required this.nationalCode,
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    required this.orders,
  });
}

class CustomerOrderItemModel {
  final String orderId;
  final String amount;
  final String date;
  final String status;
  final String? statusIcon; // SVG path if needed

  CustomerOrderItemModel({
    required this.orderId,
    required this.amount,
    required this.date,
    required this.status,
    this.statusIcon,
  });
}

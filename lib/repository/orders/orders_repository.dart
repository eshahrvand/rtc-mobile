import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../data/models/customer_model.dart';
import '../../data_source/remote/orders/model/order_dto_model.dart';
import '../../data_source/remote/orders/orders_service.dart';

class OrdersRepository {
  final OrdersService _service;

  OrdersRepository(this._service);

  Future<OrderDtoModel> createOrder(OrderCreateRequest request) {
    return _service.createOrder(request);
  }

  Future<OrderDocumentResponse> addOrderDocument(
    String orderId,
    OrderDocumentRequest request,
  ) {
    return _service.addOrderDocument(orderId, request);
  }

  Future<List<CustomerOrderItemModel>> getCustomerOrders(String customerId) {
    return _service.getOrders(customerId: customerId).then((response) {
      return response.results.map((dto) {
        final dateTime = DateTime.parse(dto.createdAt);
        final jalali = Jalali.fromDateTime(dateTime);
        final dateStr = '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';

        return CustomerOrderItemModel(
          orderId: dto.id,
          amount: _formatCurrency(dto.total),
          date: dateStr,
          status: _mapStatus(dto.status),
        );
      }).toList();
    });
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(value.abs().toInt());
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'pre_invoice':
        return 'پیش فاکتور';
      case 'approved':
        return 'تایید شده';
      case 'rejected':
        return 'رد شده';
      case 'pending':
        return 'در انتظار تایید';
      case 'waiting_settlement':
        return 'در انتظار تسویه';
      case 'expired':
        return 'منقضی شده';
      default:
        return status;
    }
  }
}

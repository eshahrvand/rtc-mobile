import 'package:rtc_mobile/data_source/remote/orders/model/order_dto_model.dart';
import 'package:rtc_mobile/data_source/remote/orders/orders_service.dart';

class OrdersRepository {
  final OrdersService _service;

  OrdersRepository(this._service);

  Future<OrderDtoModel> createOrder(OrderCreateRequest request) {
    final body = request.toJson();
    body['lines'] = request.lines.map((l) => l.toJson()).toList();
    body['documents'] = request.documents.map((d) => d.toJson()).toList();
    return _service.createOrder(body);
  }

  Future<OrderDocumentResponse> addOrderDocument(
    String orderId,
    OrderDocumentRequest request,
  ) {
    return _service.addOrderDocument(orderId, request.toJson());
  }

  Future<dynamic> disburseInitiate(String orderId, double amount) {
    return _service.disburseInitiate(orderId, {'disbursement_amount': amount});
  }

  Future<dynamic> disburse(String orderId, [Map<String, dynamic>? body]) {
    return _service.disburse(orderId, body ?? {});
  }

  Future<dynamic> settleInitiate(String id, String method, {double? amount}) {
    final body = {
      'method': method,
      if (method == 'wallet_debit' && amount != null) 'amount': amount,
    };
    return _service.settleInitiate(id, body);
  }

  Future<dynamic> settle(String id, String method, {String? trackingCode}) {
    final body = {
      'method': method,
      'payload': (method == 'card_to_card' && trackingCode != null)
          ? {'tracking_code': trackingCode}
          : {},
    };
    return _service.settle(id, body);
  }

  Future<OrderListResponse> getOrders({
    List<String>? status,
    String? subPlanId,
    String? createdAfter,
    String? createdBefore,
    String? search,
    int? page,
    int? pageSize,
    String? customerId,
  }) {
    return _service.getOrders(
      status: status,
      subPlanId: subPlanId,
      createdAfter: createdAfter,
      createdBefore: createdBefore,
      search: search,
      page: page,
      pageSize: pageSize,
      customerId: customerId,
    );
  }

  Future<OrderDtoModel> getOrderDetails(String id) {
    return _service.getOrderById(id);
  }

  Future<String> getPreInvoiceHtml(String id) {
    return _service.getPreInvoiceHtml(id);
  }

  Future<OrderListResponse> getCustomerOrders(String customerId) {
    return _service.getOrders(customerId: customerId);
  }
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/order_dto_model.dart';

part 'orders_service.g.dart';

@RestApi()
abstract class OrdersService {
  factory OrdersService(Dio dio, {String baseUrl}) = _OrdersService;

  @GET('orders/orders')
  Future<OrderListResponse> getOrders({
    @Query('agent') String? agentId,
    @Query('customer') String? customerId,
    @Query('status') List<String>? status,
    @Query('sub_plan') String? subPlanId,
    @Query('created_after') String? createdAfter,
    @Query('created_before') String? createdBefore,
    @Query('search') String? search,
    @Query('ordering') String? ordering,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('orders/orders/{id}')
  Future<OrderDtoModel> getOrderById(@Path('id') String id);

  @POST('orders/orders')
  Future<OrderDtoModel> createOrder(@Body() Map<String, dynamic> request);

  @POST('orders/orders/{id}/documents')
  Future<OrderDocumentResponse> addOrderDocument(
    @Path('id') String orderId,
    @Body() Map<String, dynamic> request,
  );

  @POST('orders/orders/{id}/disburse-initiate')
  Future<dynamic> disburseInitiate(
    @Path('id') String orderId,
    @Body() Map<String, dynamic> body,
  );

  @POST('orders/orders/{id}/disburse')
  Future<dynamic> disburse(
    @Path('id') String orderId,
    @Body() Map<String, dynamic> body,
  );

  @POST('orders/orders/{id}/settle-initiate')
  Future<dynamic> settleInitiate(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('orders/orders/{id}/settle')
  Future<dynamic> settle(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
}

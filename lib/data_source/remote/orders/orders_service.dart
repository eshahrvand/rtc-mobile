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
  Future<OrderDtoModel> createOrder(@Body() OrderCreateRequest request);

  @POST('orders/orders/{id}/documents')
  Future<OrderDocumentResponse> addOrderDocument(
    @Path('id') String orderId,
    @Body() OrderDocumentRequest request,
  );
}

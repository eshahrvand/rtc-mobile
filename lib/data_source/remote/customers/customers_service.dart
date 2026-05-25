import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/customer_dto_model.dart';

part 'customers_service.g.dart';

@RestApi()
abstract class CustomersService {
  factory CustomersService(Dio dio, {String baseUrl}) = _CustomersService;

  @GET('orders/customers')
  Future<CustomerListResponse> getCustomers({
    @Query('mobile') String? mobile,
    @Query('national_id') String? nationalId,
    @Query('ordering') String? ordering,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('search') String? search,
  });

  @GET('orders/customers/{id}')
  Future<CustomerDtoModel> getCustomerDetail(@Path('id') String id);

  @PATCH('orders/customers/{id}')
  Future<CustomerDtoModel> updateCustomer(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @POST('orders/customers')
  Future<CustomerDtoModel> createCustomer(@Body() Map<String, dynamic> body);
}

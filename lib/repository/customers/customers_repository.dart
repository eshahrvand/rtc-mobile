import '../../data_source/remote/customers/customers_service.dart';
import '../../data_source/remote/customers/model/customer_dto_model.dart';

class CustomersRepository {
  final CustomersService _customersService;

  CustomersRepository(this._customersService);

  Future<CustomerListResponse> getCustomers({
    String? search,
    int? page,
    int? pageSize,
    String? nationalId,
  }) async {
    return await _customersService.getCustomers(
      search: search,
      page: page,
      pageSize: pageSize,
      nationalId: nationalId,
    );
  }

  Future<CustomerDtoModel> getCustomerDetail(String id) async {
    return await _customersService.getCustomerDetail(id);
  }

  Future<CustomerDtoModel> getCustomerByNationalId(String nationalId) async {
    return await _customersService.getCustomerByNationalId(nationalId);
  }

  Future<CustomerDtoModel> updateCustomer(
    String nationalId,
    Map<String, dynamic> body,
  ) async {
    return await _customersService.updateCustomerByNationalId(nationalId, body);
  }

  Future<CustomerDtoModel> createCustomer(Map<String, dynamic> body) async {
    return await _customersService.createCustomer(body);
  }
}

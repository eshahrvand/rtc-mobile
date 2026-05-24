import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../repository/customers/customers_repository.dart';
import '../../../../locator.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(const CustomersState());

  final _customersRepo = sl<CustomersRepository>();

  void init() {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    _customersRepo
        .getCustomers(
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
        )
        .then((response) {
          final customers = response.results
              .map(
                (dto) => CustomerItemModel(
                  id: dto.id,
                  name: '${dto.firstName} ${dto.lastName}',
                  phoneNumber: dto.mobile,
                  city: '', // City not available in this API response yet
                ),
              )
              .toList();

          emit(
            state.copyWith(
              status: CustomersRequestStatus.success,
              allCustomers: customers,
              filteredCustomers: customers,
            ),
          );
        })
        .catchError((Object e) {
          emit(
            state.copyWith(
              status: CustomersRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    init(); // Trigger a new API fetch based on search query
  }

  void onCustomerTapped(CustomerItemModel customer) {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    // Fetching from allCustomers list as we don't have a specific Detail API yet
    // but the getCustomers response has most details except orders.
    _customersRepo
        .getCustomers(search: customer.phoneNumber)
        .then((response) {
          if (response.results.isEmpty) {
             throw Exception('Customer not found');
          }
          
          final dto = response.results.first;
          
          final detail = CustomerDetailModel(
            id: dto.id,
            name: '${dto.firstName} ${dto.lastName}',
            nationalCode: dto.nationalId,
            phoneNumber: dto.mobile,
            postalCode: dto.postalCode,
            address: dto.address,
            orders: [
              // Orders API not yet implemented per requirements
              CustomerOrderItemModel(
                orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
                amount: '۸۰,۲۰۰,۰۰۰',
                date: '۱۴۰۴/۱۰/۱۶',
                status: 'پیش فاکتور',
              ),
            ],
          );
          
          emit(state.copyWith(
            status: CustomersRequestStatus.success,
            step: CustomersStep.customerDetail,
            selectedCustomer: detail,
            selectedTabIndex: 0,
          ));
        })
        .catchError((Object e) {
          emit(
            state.copyWith(
              status: CustomersRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

  void onTabChanged(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void backToList() {
    emit(state.copyWith(
      step: CustomersStep.customerList,
      selectedCustomer: null,
    ));
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../repository/customers/customers_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../locator.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final _customersRepo = sl<CustomersRepository>();
  final _ordersRepo = sl<OrdersRepository>();
  Timer? _debounce;

  CustomersCubit() : super(const CustomersState());

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

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (query.isEmpty) {
      init();
      return;
    }

    if (query.length < 2) return;

    _debounce = Timer(const Duration(seconds: 1), () {
      init();
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  void onCustomerTapped(CustomerItemModel customer) {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    // 1. Fetch Customer Info
    _customersRepo.getCustomers(search: customer.phoneNumber).then((customerResponse) {
      if (customerResponse.results.isEmpty) {
        throw Exception('Customer not found');
      }

      final dto = customerResponse.results.first;

      // 2. Fetch Customer Orders
      return _ordersRepo.getCustomerOrders(dto.id).then((orders) {
        final detail = CustomerDetailModel(
          id: dto.id,
          name: '${dto.firstName} ${dto.lastName}',
          nationalCode: dto.nationalId,
          phoneNumber: dto.mobile,
          postalCode: dto.postalCode,
          address: dto.address,
          orders: orders,
        );

        emit(state.copyWith(
          status: CustomersRequestStatus.success,
          step: CustomersStep.customerDetail,
          selectedCustomer: detail,
          selectedTabIndex: 0,
        ));
      });
    }).catchError((Object e) {
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

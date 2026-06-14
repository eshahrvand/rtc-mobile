import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../repository/customers/customers_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../locator.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(const CustomersState());

  final _customersRepo = sl<CustomersRepository>();
  final _ordersRepo = sl<OrdersRepository>();
  Timer? _debounce;

  void init() {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    _customersRepo
        .getCustomers(
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
        )
        .then((response) {
          final customers = response.results.map(_mapToCustomerItem).toList();

          emit(
            state.copyWith(
              status: CustomersRequestStatus.success,
              allCustomers: customers,
              filteredCustomers: customers,
            ),
          );
        })
        .catchError((e) {
          _handleError(e);
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

  void onCustomerTapped(CustomerItemModel customer) {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    _customersRepo
        .getCustomerDetail(customer.id)
        .then((dto) {
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

            emit(
              state.copyWith(
                status: CustomersRequestStatus.success,
                step: CustomersStep.customerDetail,
                selectedCustomer: detail,
                selectedTabIndex: 0,
              ),
            );
          });
        })
        .catchError(_handleError);
  }

  void onTabChanged(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void backToList() {
    emit(
      state.copyWith(step: CustomersStep.customerList, selectedCustomer: null),
    );
  }

  CustomerItemModel _mapToCustomerItem(dynamic dto) {
    return CustomerItemModel(
      id: dto.id,
      name: '${dto.firstName} ${dto.lastName}',
      phoneNumber: dto.mobile,
      city: "",
    );
  }

  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();

      emit(
        state.copyWith(
          status: CustomersRequestStatus.error,
          errorMessage: finalMessage,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

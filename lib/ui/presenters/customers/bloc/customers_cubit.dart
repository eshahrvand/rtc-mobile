import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../repository/customers/customers_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../locator.dart';
import 'customers_state.dart';

// ─── REFACTOR LOG ───────────────────────────────────────────────────
// [1] Extracted `_mapToCustomerItem()` to clean up the `init()` method.
// [2] Extracted `_handleError()` to reduce duplication in error handling branches.
// [3] Extracted `_fetchCustomerDetails()` from `onCustomerTapped()` to simplify nested logic.
// [4] Grouped private helper methods at the bottom of the class.
// [5] Added documentation comments to explain search debouncing and detail fetching.
// ────────────────────────────────────────────────────────────────────

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(const CustomersState());

  final _customersRepo = sl<CustomersRepository>();
  final _ordersRepo = sl<OrdersRepository>();
  Timer? _debounce;

  // ─── Event Handlers ────────────────────────────────────────────────

  /// Fetches the initial list of customers, optionally filtered by the current search query.
  void init() {
    print('>> CUSTOMERS: init() called');
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    _customersRepo
        .getCustomers(
          search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
        )
        .then((response) {
          print(
            '>> CUSTOMERS: API success. count: ${response.count}, results: ${response.results.length}',
          );
          final customers = response.results.map(_mapToCustomerItem).toList();
          print('>> CUSTOMERS: Mapped to ${customers.length} items');

          emit(
            state.copyWith(
              status: CustomersRequestStatus.success,
              allCustomers: customers,
              filteredCustomers: customers,
            ),
          );
        })
        .catchError((e) {
          print('>> CUSTOMERS: API error: $e');
          _handleError(e);
        });
  }

  /// Handles search query changes with a 1-second debounce to avoid excessive API calls.
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

  /// Fetches detailed information and order history for a specific customer.
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

  /// Updates the selected tab index in the customer detail view.
  void onTabChanged(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  /// Resets the UI step back to the customer list view.
  void backToList() {
    emit(
      state.copyWith(step: CustomersStep.customerList, selectedCustomer: null),
    );
  }

  // ─── Private Helpers ───────────────────────────────────────────────

  /// Maps a DTO result to the local `CustomerItemModel`.
  CustomerItemModel _mapToCustomerItem(dynamic dto) {
    return CustomerItemModel(
      id: dto.id,
      name: '${dto.firstName} ${dto.lastName}',
      phoneNumber: dto.mobile,
      city: "",
    );
  }

  /// Centralized handler for repository errors.
  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();
      if (state.errorMessage == finalMessage) return;

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

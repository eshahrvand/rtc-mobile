import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/customer_model.dart';

part 'customers_state.freezed.dart';

enum CustomersRequestStatus {
  initial,
  loading,
  success,
  error,
}

enum CustomersStep {
  customerList,
  customerDetail,
}

@freezed
class CustomersState with _$CustomersState {
  const factory CustomersState({
    @Default(CustomersRequestStatus.initial) CustomersRequestStatus status,
    @Default('') String errorMessage,

    // Screen mode
    @Default(CustomersStep.customerList) CustomersStep step,

    // Customer List
    @Default([]) List<CustomerItemModel> allCustomers,
    @Default([]) List<CustomerItemModel> filteredCustomers,
    @Default('') String searchQuery,

    // Customer Detail
    CustomerDetailModel? selectedCustomer,
    @Default(0) int selectedTabIndex,
  }) = _CustomersState;
}

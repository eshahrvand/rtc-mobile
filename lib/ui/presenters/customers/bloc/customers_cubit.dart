import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/customer_model.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(const CustomersState());

  void init() {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    // Simulated fetch with mock data
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) {
          final mockCustomers = [
            CustomerItemModel(id: '1', name: 'سامان راد', phoneNumber: '۰۹۱۲۶۰۲۷۹۴۱', city: 'تهران'),
            CustomerItemModel(id: '2', name: 'علی محمدی', phoneNumber: '۰۹۱۲۱۱۱۱۱۱۱', city: 'کرج'),
            CustomerItemModel(id: '3', name: 'مریم رضایی', phoneNumber: '۰۹۱۲۲۲۲۲۲۲۲', city: 'مشهد'),
            CustomerItemModel(id: '4', name: 'سامان راد', phoneNumber: '۰۹۱۲۶۰۲۷۹۴۱', city: 'تهران'),
            CustomerItemModel(id: '5', name: 'سامان راد', phoneNumber: '۰۹۱۲۶۰۲۷۹۴۱', city: 'تهران'),
            CustomerItemModel(id: '6', name: 'سامان راد', phoneNumber: '۰۹۱۲۶۰۲۷۹۴۱', city: 'تهران'),
          ];
          emit(state.copyWith(
            status: CustomersRequestStatus.success,
            allCustomers: mockCustomers,
            filteredCustomers: mockCustomers,
          ));
        })
        .catchError((e) {
          emit(state.copyWith(
            status: CustomersRequestStatus.error,
            errorMessage: e.toString(),
          ));
        });
  }

  void onSearchChanged(String query) {
    final filtered = state.allCustomers.where((customer) {
      return customer.name.contains(query) || customer.phoneNumber.contains(query);
    }).toList();
    
    emit(state.copyWith(
      searchQuery: query,
      filteredCustomers: filtered,
    ));
  }

  void onCustomerTapped(CustomerItemModel customer) {
    emit(state.copyWith(status: CustomersRequestStatus.loading));

    // Simulated detail fetch
    Future.delayed(const Duration(milliseconds: 300))
        .then((_) {
          final detail = CustomerDetailModel(
            id: customer.id,
            name: customer.name,
            nationalCode: '۰۰۸۱۲۳۴۵۶۷',
            phoneNumber: customer.phoneNumber,
            postalCode: '۱۹۳۳۹۴۳۱۱۱',
            address: 'تهران، خیابان ولیعصر، خیابان پسیان، ساختمان آراد، واحد ۲۴',
            orders: [
              CustomerOrderItemModel(
                orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
                amount: '۸۰,۲۰۰,۰۰۰',
                date: '۱۴۰۴/۱۰/۱۶',
                status: 'پیش فاکتور',
              ),
              CustomerOrderItemModel(
                orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
                amount: '۸۰,۲۰۰,۰۰۰',
                date: '۱۴۰۴/۱۰/۱۶',
                status: 'رد شده',
              ),
              CustomerOrderItemModel(
                orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
                amount: '۸۰,۲۰۰,۰۰۰',
                date: '۱۴۰۴/۱۰/۱۶',
                status: 'منقضی شده',
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
        .catchError((e) {
          emit(state.copyWith(
            status: CustomersRequestStatus.error,
            errorMessage: e.toString(),
          ));
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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../data_source/remote/dashboard/model/dashboard_dto_model.dart';
import '../../../../data_source/remote/orders/model/order_dto_model.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../locator.dart';
import '../../../../generated/l10n.dart';
import '../../../../config/errorhandler.dart';
import '../mapper/dashboard_mapper.dart';
import '../../orders/mapper/order_mapper.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({int initialIndex = 0})
    : super(DashboardState(selectedNavIndex: initialIndex));

  final _dashboardRepo = sl<DashboardRepository>();
  final _ordersRepo = sl<OrdersRepository>();

  void init() {
    emit(state.copyWith(status: DashboardRequestStatus.loading));
    _loadAppInfo();

    _dashboardRepo
        .getMyProfile()
        .then((profile) {
          emit(state.copyWith(userProfile: profile));
          _loadDashboardData();
        })
        .catchError((Object e) {
          _loadDashboardData();
          emit(state.copyWith(
            status: DashboardRequestStatus.error,
            errorMessage: ErrorHandler.getMessage(e),
          ));
        });
  }

  void _loadAppInfo() {
    PackageInfo.fromPlatform().then((info) {
      if (!isClosed) {
        emit(state.copyWith(
          appVersion: info.version,
          buildNumber: info.buildNumber,
        ));
      }
    }).catchError((_) {});
  }

  void onNavItemSelected(int index) {
    emit(state.copyWith(selectedNavIndex: index));
  }

  void _loadDashboardData() {
    Future.wait([
          _dashboardRepo.getSummary(),
          _dashboardRepo.getDailyChart(),
          _dashboardRepo.getCategories(),
          _dashboardRepo.getSubPlanChart(),
          _ordersRepo.getOrders(page: 1, pageSize: 5),
          _dashboardRepo.getOrderStatus(),
          _dashboardRepo.getCommission(),
        ])
        .then<void>((results) {
          final summary = results[0] as DashboardSummaryDtoModel;
          final dailyChart = results[1] as List<DailyChartDtoModel>;
          final categories = results[2] as List<CategoryChartDtoModel>;
          final subplans = results[3] as List<SubPlanChartDtoModel>;
          final orderResponse = results[4] as OrderListResponse;
          final orderStatuses = results[5] as List<OrderStatusDtoModel>;
          final commission = results[6] as CommissionDtoModel;

          emit(
            state.copyWith(
              status: DashboardRequestStatus.success,
              quickAccessItems: DashboardMapper.mapQuickAccessItems(summary, commission),
              lineChartData: [DashboardMapper.mapLineChartData(dailyChart)],
              pieChart1Title: S.current.orderStatusChartTitle,
              pieChart1Data: DashboardMapper.mapOrderStatusChart(orderStatuses),
              pieChart2Title: S.current.salesByCategoryChartTitle,
              pieChart2Data: DashboardMapper.mapCategoryChart(categories),
              barChartTitle: S.current.plansSalesChartTitle,
              barChartData: DashboardMapper.mapSubPlanChart(subplans),
              recentOrders: orderResponse.results.map((dto) => OrderMapper.mapToSummary(dto)).toList(),
              commission: commission,
              messageText: DashboardMapper.formatCommissionMessage(commission),
              messageIconPath: 'assets/images/alert.svg',
            ),
          );
        })
        .catchError((e) => emit(state.copyWith(
              status: DashboardRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            )));
  }
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../profile/model/user_profile_dto_model.dart';

import 'model/dashboard_dto_model.dart';

part 'dashboard_service.g.dart';

@RestApi()
abstract class DashboardService {
  factory DashboardService(Dio dio, {String baseUrl}) = _DashboardService;

  @GET('accounts/users/')
  Future<ProfileListResponse> getUserProfiles();

  @GET('dashboard/summary')
  Future<DashboardSummaryDtoModel> getSummary();

  @GET('dashboard/wallet-status')
  Future<List<WalletStatusDtoModel>> getWalletStatus();

  @GET('dashboard/daily-chart')
  Future<List<DailyChartDtoModel>> getDailyChart();

  @GET('dashboard/categories')
  Future<List<CategoryChartDtoModel>> getCategories();

  @GET('dashboard/subplan-chart')
  Future<List<SubPlanChartDtoModel>> getSubPlanChart();
}

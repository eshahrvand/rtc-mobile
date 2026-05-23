import '../../data_source/remote/dashboard/dashboard_service.dart';
import '../../data_source/remote/dashboard/model/dashboard_dto_model.dart';
import '../../data_source/remote/profile/model/user_profile_dto_model.dart';

class DashboardRepository {
  final DashboardService _dashboardService;

  DashboardRepository(this._dashboardService);

  Future<UserProfileDtoModel?> getMyProfile() async {
    final response = await _dashboardService.getUserProfiles();
    if (response.results.isNotEmpty) {
      return response.results.first;
    }
    return null;
  }

  Future<DashboardSummaryDtoModel> getSummary() async {
    return await _dashboardService.getSummary();
  }

  Future<List<WalletStatusDtoModel>> getWalletStatus() async {
    return await _dashboardService.getWalletStatus();
  }

  Future<List<DailyChartDtoModel>> getDailyChart() async {
    return await _dashboardService.getDailyChart();
  }

  Future<List<CategoryChartDtoModel>> getCategories() async {
    return await _dashboardService.getCategories();
  }

  Future<List<SubPlanChartDtoModel>> getSubPlanChart() async {
    return await _dashboardService.getSubPlanChart();
  }
}

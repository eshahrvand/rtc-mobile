import '../../data_source/remote/dashboard/dashboard_service.dart';
import '../../data_source/remote/profile/model/user_profile_dto_model.dart';

class DashboardRepository {
  final DashboardService _dashboardService;

  DashboardRepository(this._dashboardService);

  Future<UserProfileDtoModel?> getMyProfile() async {
    final response = await _dashboardService.getUserProfiles();
    // Assuming the first result is the current user for now as per pagination pattern
    if (response.results.isNotEmpty) {
      return response.results.first;
    }
    return null;
  }
}

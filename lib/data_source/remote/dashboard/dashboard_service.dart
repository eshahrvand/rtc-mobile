import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../profile/model/user_profile_dto_model.dart';

part 'dashboard_service.g.dart';

@RestApi()
abstract class DashboardService {
  factory DashboardService(Dio dio, {String baseUrl}) = _DashboardService;

  @GET('accounts/users/')
  Future<ProfileListResponse> getUserProfiles();
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/plan_dto_model.dart';

part 'plans_service.g.dart';

@RestApi()
abstract class PlansService {
  factory PlansService(Dio dio, {String baseUrl}) = _PlansService;

  @GET('plans/sub-plans')
  Future<SubPlanListResponse> getSubPlans(@Query('page') int? page);
}

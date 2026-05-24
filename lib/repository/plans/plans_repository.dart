import '../../data_source/remote/plans/model/plan_dto_model.dart';
import '../../data_source/remote/plans/plans_service.dart';

class PlansRepository {
  final PlansService _plansService;

  PlansRepository(this._plansService);

  Future<SubPlanListResponse> getSubPlans() async {
    return await _plansService.getSubPlans();
  }
}

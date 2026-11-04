import 'package:cross_file/cross_file.dart';
import '../../core/models/workspace_models.dart';
import '../../data_source/remote/media/media_service.dart';
import '../../data_source/remote/workspace/workspace_service.dart';
import '../../data_source/remote/profile/model/user_profile_dto_model.dart';
import 'workspace_mapper.dart';

/// Production callbacks follow the supplied backend contracts. Capabilities with
/// no supplied endpoint stay unavailable; only the preview injects test data.
class WorkspaceRepository {
  WorkspaceRepository({
    this.loadMe,
    this.loadBranch,
    this.loadEmployee,
    this.loadPolicyHtml,
    this.loadTerms,
    this.acceptTerms,
    this.checkTerms,
    this.loadBanners,
    this.loadBranches,
    this.searchBranches,
    this.loadEmployees,
    this.saveEmployee,
    this.deleteEmployee,
    this.uploadAvatar,
    this.submitRefund,
    this.isTermsRequiredResponse,
  });

  factory WorkspaceRepository.remote(WorkspaceService service) =>
      WorkspaceRepository(
        loadMe: service.getMe,
        loadBanners: () => service.activeSlider().then(WorkspaceMapper.slider),
        uploadAvatar: (file, userId) => MediaService(service.dio)
            .uploadImage(imageGroup: 'user_avatar', xFile: file)
            .then((image) => service.setAvatar(userId, image.id)),
        loadTerms: () => service.currentPolicy().then(
          (json) => json == null ? null : WorkspaceMapper.policy(json),
        ),
        acceptTerms: (version) => service
            .acceptPolicy(int.parse(version))
            .then(WorkspaceMapper.policy),
        loadPolicyHtml: service.policyHtml,
        loadBranches: () => service.stores().then(
          (items) => items.map(WorkspaceMapper.branch).toList(),
        ),
        searchBranches: (query) => service
            .stores(search: query)
            .then((items) => items.map(WorkspaceMapper.branch).toList()),
        loadBranch: (id) => service.store(id).then(WorkspaceMapper.branch),
        loadEmployees: (id) => service
            .employees(id)
            .then((items) => items.map(WorkspaceMapper.employee).toList()),
        loadEmployee: (id) =>
            service.employee(id).then(WorkspaceMapper.employee),
        saveEmployee: (employee) =>
            Future.sync(() => WorkspaceMapper.employeeBody(employee))
                .then((body) => service.saveEmployee(employee.id, body))
                .then(WorkspaceMapper.employee),
        deleteEmployee: service.deleteEmployee,
        isTermsRequiredResponse: (body) =>
            body is Map &&
            body['error'] is Map &&
            const {
              'policy_acceptance_required',
              'agent_policy_pending',
            }.contains(body['error']['code']),
      );
  final Future<UserProfileDtoModel> Function()? loadMe;
  final Future<BranchInfo> Function(String id)? loadBranch;
  final Future<BranchEmployee> Function(String id)? loadEmployee;
  final Future<String> Function(String id)? loadPolicyHtml;
  final Future<TermsDocument?> Function()? loadTerms;
  final Future<TermsDocument> Function(String version)? acceptTerms;
  final Future<bool> Function()? checkTerms;
  final Future<List<HomeBanner>> Function()? loadBanners;
  final Future<List<BranchInfo>> Function()? loadBranches;
  final Future<List<BranchInfo>> Function(String query)? searchBranches;
  final Future<List<BranchEmployee>> Function(String branchId)? loadEmployees;
  final Future<BranchEmployee> Function(BranchEmployee employee)? saveEmployee;
  final Future<void> Function(String id)? deleteEmployee;
  final Future<String> Function(XFile file, String userId)? uploadAvatar;
  final Future<void> Function(String orderId)? submitRefund;
  final bool Function(Object? responseBody)? isTermsRequiredResponse;

  Future<T> unavailable<T>() => Future.error(const WorkspaceServicePending());
}

class WorkspaceServicePending implements Exception {
  const WorkspaceServicePending();
}

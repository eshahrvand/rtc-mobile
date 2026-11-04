import 'package:flutter/foundation.dart';
import '../../../../core/models/workspace_models.dart';
import '../../../../data_source/remote/profile/model/user_profile_dto_model.dart';

enum PolicyGate { ok, mustAccept, agentPending }

enum WorkspaceStatus { initial, loading, success, error }

const _unset = Object();

// Explicit immutable states keep this UI addition independent of the legacy
// code-generator/SDK incompatibility. Nullable fields support explicit clearing.
@immutable
class WorkspaceState {
  const WorkspaceState({
    this.role = AccountRole.agent,
    this.profile,
    this.position = '',
    this.postalCode = '',
    this.companyName = '',
    this.avatar,
    this.avatarPreview,
    this.avatarStatus = WorkspaceStatus.initial,
    this.terms,
    this.policyDownloadLoading = false,
    this.policyDownloadSaved = false,
    this.termsRequired = false,
    this.termsChecked = false,
    this.termsStatus = WorkspaceStatus.initial,
    this.banners = const [],
    this.branches = const [],
    this.branchSearch = '',
    this.branchSearchActive = false,
    this.branchesStatus = WorkspaceStatus.initial,
    this.selectedBranch,
    this.branchTab = 0,
    this.employees = const [],
    this.employeesStatus = WorkspaceStatus.initial,
    this.employeeSaveStatus = WorkspaceStatus.initial,
    this.employeeFieldErrors = const {},
    this.refundRequestedIds = const {},
    this.refundSubmittingIds = const {},
    this.errorMessage = '',
  });
  final AccountRole role;
  final UserProfileDtoModel? profile;
  final String position;
  final String postalCode;
  final String companyName;
  final String? avatar;
  final Uint8List? avatarPreview;
  final WorkspaceStatus avatarStatus;
  final TermsDocument? terms;
  final bool policyDownloadLoading;
  final bool policyDownloadSaved;
  final bool termsRequired;
  final bool termsChecked;
  final WorkspaceStatus termsStatus;
  final List<HomeBanner> banners;
  final List<BranchInfo> branches;
  final String branchSearch;
  final bool branchSearchActive;
  final WorkspaceStatus branchesStatus;
  final BranchInfo? selectedBranch;
  final int branchTab;
  final List<BranchEmployee> employees;
  final WorkspaceStatus employeesStatus;
  final WorkspaceStatus employeeSaveStatus;
  final Map<String, List<String>> employeeFieldErrors;
  final Set<String> refundRequestedIds;
  final Set<String> refundSubmittingIds;
  final String errorMessage;

  WorkspaceState copyWith({
    AccountRole? role,
    Object? profile = _unset,
    String? position,
    String? postalCode,
    String? companyName,
    Object? avatar = _unset,
    Object? avatarPreview = _unset,
    WorkspaceStatus? avatarStatus,
    Object? terms = _unset,
    bool? policyDownloadLoading,
    bool? policyDownloadSaved,
    bool? termsRequired,
    bool? termsChecked,
    WorkspaceStatus? termsStatus,
    List<HomeBanner>? banners,
    List<BranchInfo>? branches,
    String? branchSearch,
    bool? branchSearchActive,
    WorkspaceStatus? branchesStatus,
    Object? selectedBranch = _unset,
    int? branchTab,
    List<BranchEmployee>? employees,
    WorkspaceStatus? employeesStatus,
    WorkspaceStatus? employeeSaveStatus,
    Map<String, List<String>>? employeeFieldErrors,
    Set<String>? refundRequestedIds,
    Set<String>? refundSubmittingIds,
    String? errorMessage,
  }) => WorkspaceState(
    role: role ?? this.role,
    profile: identical(profile, _unset)
        ? this.profile
        : profile as UserProfileDtoModel?,
    position: position ?? this.position,
    postalCode: postalCode ?? this.postalCode,
    companyName: companyName ?? this.companyName,
    avatar: identical(avatar, _unset) ? this.avatar : avatar as String?,
    avatarPreview: identical(avatarPreview, _unset)
        ? this.avatarPreview
        : avatarPreview as Uint8List?,
    avatarStatus: avatarStatus ?? this.avatarStatus,
    terms: identical(terms, _unset) ? this.terms : terms as TermsDocument?,
    policyDownloadLoading: policyDownloadLoading ?? this.policyDownloadLoading,
    policyDownloadSaved: policyDownloadSaved ?? this.policyDownloadSaved,
    termsRequired: termsRequired ?? this.termsRequired,
    termsChecked: termsChecked ?? this.termsChecked,
    termsStatus: termsStatus ?? this.termsStatus,
    banners: banners == null ? this.banners : List.unmodifiable(banners),
    branches: branches == null ? this.branches : List.unmodifiable(branches),
    branchSearch: branchSearch ?? this.branchSearch,
    branchSearchActive: branchSearchActive ?? this.branchSearchActive,
    branchesStatus: branchesStatus ?? this.branchesStatus,
    selectedBranch: identical(selectedBranch, _unset)
        ? this.selectedBranch
        : selectedBranch as BranchInfo?,
    branchTab: branchTab ?? this.branchTab,
    employees: employees == null
        ? this.employees
        : List.unmodifiable(employees),
    employeesStatus: employeesStatus ?? this.employeesStatus,
    employeeSaveStatus: employeeSaveStatus ?? this.employeeSaveStatus,
    employeeFieldErrors: employeeFieldErrors == null
        ? this.employeeFieldErrors
        : Map.unmodifiable(employeeFieldErrors),
    refundRequestedIds: Set.unmodifiable(
      refundRequestedIds ?? this.refundRequestedIds,
    ),
    refundSubmittingIds: Set.unmodifiable(
      refundSubmittingIds ?? this.refundSubmittingIds,
    ),
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

@immutable
class EmployeeFormState {
  const EmployeeFormState({
    this.firstName = '',
    this.lastName = '',
    this.nationalId = '',
    this.mobile = '',
    this.position = '',
    this.isActive = false,
  });
  final String firstName;
  final String lastName;
  final String nationalId;
  final String mobile;
  final String position;
  final bool isActive;

  EmployeeFormState copyWith({
    String? firstName,
    String? lastName,
    String? nationalId,
    String? mobile,
    String? position,
    bool? isActive,
  }) => EmployeeFormState(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    nationalId: nationalId ?? this.nationalId,
    mobile: mobile ?? this.mobile,
    position: position ?? this.position,
    isActive: isActive ?? this.isActive,
  );
}

extension WorkspaceStateX on WorkspaceState {
  PolicyGate get policyGate => !termsRequired
      ? PolicyGate.ok
      : role == AccountRole.agent
      ? PolicyGate.mustAccept
      : PolicyGate.agentPending;
  List<BranchInfo> get filteredBranches => branches;
  bool get canManageBranches => role == AccountRole.agent;
}

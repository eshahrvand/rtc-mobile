import 'dart:async';
import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/errorhandler.dart';
import '../../../../core/models/workspace_models.dart';
import '../../../../data_source/remote/profile/model/user_profile_dto_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/service/html_document_exporter.dart';
import '../../../../repository/workspace/workspace_repository.dart';
import 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  WorkspaceCubit(
    this.repository, {
    WorkspaceState initialState = const WorkspaceState(),
    Future<String> Function(String html, String name)? exportHtml,
  }) : exportHtml = exportHtml ?? HtmlDocumentExporter.export,
       super(initialState);
  final Future<String> Function(String html, String name) exportHtml;
  final WorkspaceRepository repository;
  int _employeeRequest = 0;
  int _bannerRequest = 0;
  int _branchRequest = 0;
  Timer? _branchSearchTimer;
  int _termsRequest = 0;
  int _epoch = 0;
  bool _active(int epoch) => !isClosed && epoch == _epoch;

  String _message(Object error) => error is WorkspaceServicePending
      ? S.current.workspaceServicePending
      : ErrorHandler.getMessage(error);

  void setProfile(
    UserProfileDtoModel? profile, {
    AccountRole? role,
    bool applyPolicy = true,
    String? position,
    String? postalCode,
    String? companyName,
    String? avatar,
  }) {
    if (profile?.id != state.profile?.id) {
      _epoch++;
      _employeeRequest++;
      emit(const WorkspaceState());
    }
    emit(
      state.copyWith(
        profile: profile,
        role:
            role ??
            (profile?.role == 'employee' || profile?.role == 'sales_person'
                ? AccountRole.employee
                : AccountRole.agent),
        avatar: avatar ?? profile?.avatar?.file,
        position: position ?? state.position,
        postalCode: postalCode ?? profile?.postalCode ?? state.postalCode,
        companyName: companyName ?? state.companyName,
      ),
    );
    // Preview fixtures may intentionally drive the gate without a /me service.
    if (applyPolicy && repository.loadMe != null) {
      final policySubject =
          profile != null &&
          const {'agent', 'sales_person', 'employee'}.contains(profile.role);
      if (policySubject && profile.policyStatus?.required == true) {
        requireTerms();
      } else {
        emit(state.copyWith(termsRequired: false, termsChecked: false));
      }
    }
  }

  Future<void> refreshMe() {
    final epoch = _epoch;
    final loader = repository.loadMe;
    if (loader == null) return Future.value();
    return loader().then((profile) {
      if (_active(epoch)) setProfile(profile);
    });
  }

  void blockPolicy(String code) {
    final profile = state.profile;
    if (profile != null &&
        !const {'agent', 'sales_person', 'employee'}.contains(profile.role))
      return;
    if (!const {
      'policy_acceptance_required',
      'agent_policy_pending',
    }.contains(code))
      return;
    emit(
      state.copyWith(
        role: code == 'agent_policy_pending'
            ? AccountRole.employee
            : AccountRole.agent,
      ),
    );
    requireTerms();
  }

  void loadHomeBanners() {
    final epoch = _epoch;
    final request = ++_bannerRequest;
    final load = repository.loadBanners;
    if (load == null) return;
    load()
        .then((items) {
          if (_active(epoch) && request == _bannerRequest) {
            emit(state.copyWith(banners: items));
          }
        })
        .catchError((Object _) {
          if (_active(epoch) && request == _bannerRequest) {
            emit(state.copyWith(banners: []));
          }
        });
  }

  void loadTerms() {
    final epoch = _epoch;
    final request = ++_termsRequest;
    emit(
      state.copyWith(
        terms: null,
        termsChecked: false,
        policyDownloadSaved: false,
        termsStatus: WorkspaceStatus.loading,
        errorMessage: '',
      ),
    );
    (repository.loadTerms?.call() ?? repository.unavailable<TermsDocument?>())
        .then((document) {
          if (_active(epoch) && request == _termsRequest) {
            emit(
              state.copyWith(
                terms: document,
                termsStatus: WorkspaceStatus.success,
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch) && request == _termsRequest) {
            emit(
              state.copyWith(
                termsStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  /// Invoke only when the backend explicitly identifies a terms-related 403.
  /// Other permission-denied responses must retain their original behavior.
  void requireTerms({TermsDocument? document}) {
    _branchSearchTimer?.cancel();
    _branchRequest++;
    _employeeRequest++;
    if (state.termsRequired &&
        (document == null || document.version == state.terms?.version)) {
      return;
    }
    emit(
      state.copyWith(
        termsRequired: true,
        termsChecked: false,
        terms: document,
        termsStatus: WorkspaceStatus.initial,
        errorMessage: '',
      ),
    );
    if (document == null && state.role == AccountRole.agent) loadTerms();
  }

  void checkAgreement(bool value) => emit(state.copyWith(termsChecked: value));
  void confirmTerms() {
    final epoch = _epoch;
    if (state.role != AccountRole.agent ||
        !state.termsChecked ||
        state.terms == null ||
        state.termsStatus == WorkspaceStatus.loading) {
      return;
    }
    final version = state.terms!.version;
    emit(
      state.copyWith(termsStatus: WorkspaceStatus.loading, errorMessage: ''),
    );
    (repository.acceptTerms?.call(version) ??
            repository.unavailable<TermsDocument>())
        .then((document) {
          if (!_active(epoch) || state.terms?.version != version)
            return Future<void>.value();
          if (repository.loadMe != null) {
            return refreshMe().then((_) {
              if (_active(epoch))
                emit(
                  state.copyWith(
                    termsStatus: WorkspaceStatus.success,
                    termsChecked: false,
                  ),
                );
            });
          }
          if (_active(epoch) && state.terms?.version == version) {
            emit(
              state.copyWith(
                terms: document,
                termsRequired: false,
                termsChecked: false,
                termsStatus: WorkspaceStatus.success,
              ),
            );
          }
          return Future<void>.value();
        })
        .catchError((Object error) {
          if (_active(epoch) && state.terms?.version == version) {
            if (ErrorHandler.getApiError(error)?.code ==
                'policy_version_outdated') {
              final message = _message(error);
              emit(state.copyWith(termsChecked: false));
              loadTerms();
              emit(state.copyWith(errorMessage: message));
              return;
            }
            emit(
              state.copyWith(
                termsStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void recheckTerms() {
    final epoch = _epoch;
    if (state.termsStatus == WorkspaceStatus.loading) return;
    emit(
      state.copyWith(termsStatus: WorkspaceStatus.loading, errorMessage: ''),
    );
    (repository.loadMe != null
            ? refreshMe().then((_) => !state.termsRequired)
            : repository.checkTerms?.call() ?? repository.unavailable<bool>())
        .then((accepted) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                termsRequired: !accepted,
                termsStatus: WorkspaceStatus.success,
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                termsStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void downloadTerms() {
    final id = state.terms?.id;
    final loader = repository.loadPolicyHtml;
    if (id == null || loader == null || state.policyDownloadLoading) return;
    final epoch = _epoch;
    emit(
      state.copyWith(
        policyDownloadLoading: true,
        policyDownloadSaved: false,
        errorMessage: '',
      ),
    );
    loader(id)
        .then((html) => exportHtml(html, 'privacy_policy_$id'))
        .then((_) {
          if (_active(epoch))
            emit(
              state.copyWith(
                policyDownloadLoading: false,
                policyDownloadSaved: true,
              ),
            );
        })
        .catchError((Object error) {
          if (_active(epoch))
            emit(
              state.copyWith(
                policyDownloadLoading: false,
                errorMessage: _message(error),
              ),
            );
        });
  }

  void selectAvatar(XFile file, Uint8List bytes) {
    final userId = state.profile?.id;
    if (userId == null || userId.isEmpty) {
      reportAvatarError(StateError('Current account is unavailable'));
      return;
    }
    final epoch = _epoch;
    emit(
      state.copyWith(
        avatarPreview: bytes,
        avatarStatus: WorkspaceStatus.loading,
        errorMessage: '',
      ),
    );
    (repository.uploadAvatar?.call(file, userId) ??
            repository.unavailable<String>())
        .then((url) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                avatar: url,
                avatarStatus: WorkspaceStatus.success,
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                avatarPreview: null,
                avatarStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void beginAvatarSelection() => emit(
    state.copyWith(avatarStatus: WorkspaceStatus.initial, errorMessage: ''),
  );
  void reportAvatarError(Object error) => emit(
    state.copyWith(
      avatarStatus: WorkspaceStatus.error,
      errorMessage: _message(error),
    ),
  );

  void loadBranches() {
    final epoch = _epoch;
    final request = ++_branchRequest;
    final query = state.branchSearch.trim();
    if (!state.canManageBranches) return;
    emit(
      state.copyWith(branchesStatus: WorkspaceStatus.loading, errorMessage: ''),
    );
    (repository.searchBranches?.call(query) ??
            repository.loadBranches?.call() ??
            repository.unavailable<List<BranchInfo>>())
        .then((items) {
          if (_active(epoch) &&
              request == _branchRequest &&
              query == state.branchSearch.trim()) {
            emit(
              state.copyWith(
                branches: items,
                branchesStatus: WorkspaceStatus.success,
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch) &&
              request == _branchRequest &&
              query == state.branchSearch.trim()) {
            emit(
              state.copyWith(
                branchesStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void searchBranches(String value) {
    _branchSearchTimer?.cancel();
    _branchRequest++;
    emit(state.copyWith(branchSearch: value));
    _branchSearchTimer = Timer(const Duration(seconds: 1), loadBranches);
  }

  void toggleBranchSearch() {
    _branchSearchTimer?.cancel();
    _branchRequest++;
    final closing = state.branchSearchActive;
    emit(state.copyWith(branchSearchActive: !closing, branchSearch: ''));
    if (closing) loadBranches();
  }

  void openBranch(BranchInfo branch) {
    if (!state.canManageBranches) return;
    emit(
      state.copyWith(
        selectedBranch: branch,
        branchTab: 0,
        employees: [],
        employeesStatus: WorkspaceStatus.initial,
      ),
    );
  }

  void selectBranch(BranchInfo branch) {
    final epoch = _epoch;
    if (!state.canManageBranches) return;
    final request = ++_employeeRequest;
    emit(
      state.copyWith(
        selectedBranch: branch,
        branchTab: 0,
        employees: [],
        employeesStatus: WorkspaceStatus.loading,
        errorMessage: '',
      ),
    );
    (repository.loadBranch?.call(branch.id) ?? Future.value(branch))
        .then((fresh) {
          if (_active(epoch) && request == _employeeRequest)
            emit(state.copyWith(selectedBranch: fresh));
          return repository.loadEmployees?.call(branch.id) ??
              repository.unavailable<List<BranchEmployee>>();
        })
        .then((items) {
          if (_active(epoch) && request == _employeeRequest) {
            emit(
              state.copyWith(
                employees: items,
                employeesStatus: WorkspaceStatus.success,
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch) && request == _employeeRequest) {
            emit(
              state.copyWith(
                employeesStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void loadEmployeeDetails(String id) {
    final loader = repository.loadEmployee;
    if (loader == null || !state.canManageBranches) return;
    final epoch = _epoch;
    final branchId = state.selectedBranch?.id;
    loader(id)
        .then((employee) {
          if (_active(epoch) &&
              state.selectedBranch?.id == branchId &&
              employee.branchId == branchId) {
            emit(
              state.copyWith(
                employees: [
                  for (final current in state.employees)
                    if (current.id == id) employee else current,
                ],
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch))
            emit(state.copyWith(errorMessage: _message(error)));
        });
  }

  void selectBranchTab(int index) => emit(state.copyWith(branchTab: index));
  void resetEmployeeAction() => emit(
    state.copyWith(
      employeeSaveStatus: WorkspaceStatus.initial,
      employeeFieldErrors: {},
      errorMessage: '',
    ),
  );
  void clearEmployeeFieldError(String field) {
    if (!state.employeeFieldErrors.containsKey(field)) return;
    emit(
      state.copyWith(
        employeeFieldErrors: {...state.employeeFieldErrors}..remove(field),
      ),
    );
  }

  void saveEmployee(BranchEmployee employee) {
    final epoch = _epoch;
    if (!state.canManageBranches ||
        state.employeeSaveStatus == WorkspaceStatus.loading) {
      return;
    }
    emit(
      state.copyWith(
        employeeSaveStatus: WorkspaceStatus.loading,
        employeeFieldErrors: {},
        errorMessage: '',
      ),
    );
    (repository.saveEmployee?.call(employee) ??
            repository.unavailable<BranchEmployee>())
        .then((saved) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                employeeSaveStatus: WorkspaceStatus.success,
                employees: [
                  ...state.employees.where((e) => e.id != saved.id),
                  saved,
                ],
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                employeeSaveStatus: WorkspaceStatus.error,
                employeeFieldErrors:
                    ErrorHandler.getApiError(error)?.fieldErrors ?? {},
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void deleteEmployee(BranchEmployee employee) {
    final epoch = _epoch;
    if (!state.canManageBranches ||
        state.employeeSaveStatus == WorkspaceStatus.loading) {
      return;
    }
    emit(
      state.copyWith(
        employeeSaveStatus: WorkspaceStatus.loading,
        errorMessage: '',
      ),
    );
    (repository.deleteEmployee?.call(employee.id) ??
            repository.unavailable<void>())
        .then((_) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                employeeSaveStatus: WorkspaceStatus.success,
                employees: state.employees
                    .where((e) => e.id != employee.id)
                    .toList(),
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                employeeSaveStatus: WorkspaceStatus.error,
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void requestRefund(String orderId) {
    final epoch = _epoch;
    if (state.refundRequestedIds.contains(orderId) ||
        state.refundSubmittingIds.contains(orderId)) {
      return;
    }
    emit(
      state.copyWith(
        refundSubmittingIds: {...state.refundSubmittingIds, orderId},
        errorMessage: '',
      ),
    );
    (repository.submitRefund?.call(orderId) ?? repository.unavailable<void>())
        .then((_) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                refundRequestedIds: {...state.refundRequestedIds, orderId},
                refundSubmittingIds: {...state.refundSubmittingIds}
                  ..remove(orderId),
              ),
            );
          }
        })
        .catchError((Object error) {
          if (_active(epoch)) {
            emit(
              state.copyWith(
                refundSubmittingIds: {...state.refundSubmittingIds}
                  ..remove(orderId),
                errorMessage: _message(error),
              ),
            );
          }
        });
  }

  void reset() {
    _branchSearchTimer?.cancel();
    _branchRequest++;
    _epoch++;
    _employeeRequest++;
    emit(const WorkspaceState());
  }

  @override
  Future<void> close() {
    _branchSearchTimer?.cancel();
    _epoch++;
    return super.close();
  }
}

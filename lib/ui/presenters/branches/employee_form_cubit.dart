import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';
import '../../../config/regex_national_number_validator.dart';
import '../../../core/models/workspace_models.dart';
import '../workspace/bloc/workspace_state.dart';

class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  EmployeeFormCubit(BranchEmployee? employee)
    : super(
        EmployeeFormState(
          firstName: employee?.firstName ?? '',
          lastName: employee?.lastName ?? '',
          nationalId: employee?.nationalId ?? '',
          mobile: employee?.mobile ?? '',
          position: employee?.position ?? '',
          isActive: employee?.isActive ?? false,
        ),
      );
  void update(String field, String value) {
    emit(switch (field) {
      'firstName' => state.copyWith(firstName: value),
      'lastName' => state.copyWith(lastName: value),
      'nationalId' => state.copyWith(nationalId: normalizeDigits(value)),
      'mobile' => state.copyWith(mobile: normalizeDigits(value)),
      'position' => state.copyWith(position: value),
      _ => state,
    });
  }

  void setActive(bool value) => emit(state.copyWith(isActive: value));
  String? get nationalIdError =>
      state.nationalId.isEmpty ||
          (RegExp(r'^\d{10}$').hasMatch(state.nationalId) &&
              isNationalIDValid(state.nationalId))
      ? null
      : S.current.nationalIdWrong;
  String? get mobileError =>
      state.mobile.isEmpty || RegExp(r'^09\d{9}$').hasMatch(state.mobile)
      ? null
      : S.current.phoneNumberWrong;
  bool get isValid =>
      state.firstName.trim().isNotEmpty &&
      state.lastName.trim().isNotEmpty &&
      RegExp(r'^\d{10}$').hasMatch(state.nationalId) &&
      isNationalIDValid(state.nationalId) &&
      RegExp(r'^09\d{9}$').hasMatch(state.mobile) &&
      state.position.isNotEmpty;
  BranchEmployee buildEmployee({
    required String branchId,
    String? id,
    String? avatar,
  }) => BranchEmployee(
    id: id ?? '',
    branchId: branchId,
    firstName: state.firstName.trim(),
    lastName: state.lastName.trim(),
    nationalId: state.nationalId,
    mobile: state.mobile,
    position: state.position,
    isActive: state.isActive,
    avatar: avatar,
  );
}

String normalizeDigits(String value) {
  const fa = '۰۱۲۳۴۵۶۷۸۹';
  const ar = '٠١٢٣٤٥٦٧٨٩';
  return value
      .split('')
      .map(
        (c) => fa.contains(c)
            ? fa.indexOf(c).toString()
            : ar.contains(c)
            ? ar.indexOf(c).toString()
            : c,
      )
      .join();
}

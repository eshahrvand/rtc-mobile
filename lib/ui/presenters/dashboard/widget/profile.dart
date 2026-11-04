import '../../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/workspace_models.dart';
import '../../../../repository/workspace/workspace_mapper.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../data_source/remote/profile/model/user_profile_dto_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../config/snackbar.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_appbar.dart';
import '../../../widget/rtc_info_row.dart';
import '../../../widget/rtc_image.dart';
import '../../workspace/bloc/workspace_cubit.dart';
import '../../workspace/bloc/workspace_state.dart';
import 'profile_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.userProfile});
  final UserProfileDtoModel? userProfile;

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<WorkspaceCubit, WorkspaceState>(
    listenWhen: (previous, current) =>
        previous.avatarStatus != current.avatarStatus,
    listener: (context, state) {
      if (state.avatarStatus == WorkspaceStatus.error) {
        rtcSnackBar(
          context: context,
          type: SnackBarType.error,
          message: state.errorMessage,
        );
      }
    },
    builder: (context, state) {
      final profile = state.profile ?? userProfile;
      final employee = state.role == AccountRole.employee;
      final legal = profile?.agentType != 'natural';
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: RtcAppBar(
          toolbarHeight: 64,
          titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.grayPalette.shade800,
          ),
          title: S.current.profile,
          backIconPath: 'assets/images/angle-right.svg',
          onBack: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.dashboard),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileAvatar(),
                RtcInfoSection(
                  title: employee
                      ? S.current.userInformation
                      : S.current.agencyInformation,
                  icon: 'assets/images/workspace_user_info.svg',
                  children: [
                    if (!employee) ...[
                      RtcInfoRow(
                        label: S.current.agencyType,
                        value: legal
                            ? S.current.legalAgency
                            : S.current.naturalAgency,
                      ),
                      RtcInfoRow(
                        label: S.current.agencyCode,
                        value: profile?.agentCode ?? '',
                      ),
                    ],
                    RtcInfoRow(
                      label: employee
                          ? S.current.fullNameLabel
                          : legal
                          ? S.current.companyName
                          : S.current.agentName,
                      value: legal && !employee
                          ? state.companyName
                          : '${profile?.firstName ?? ''} ${profile?.lastName ?? ''}'
                                .trim(),
                    ),
                    RtcInfoRow(
                      label: legal && !employee
                          ? S.current.legalId
                          : S.current.nationalId,
                      value: profile?.nationalCode ?? '',
                    ),
                    RtcInfoRow(
                      label: S.current.mobileLabel,
                      value: profile?.mobile ?? '',
                    ),
                    if (employee)
                      RtcInfoRow(
                        label: S.current.employeePosition,
                        value: state.position.isNotEmpty
                            ? WorkspaceMapper.resolvePosition(
                                state.position,
                                fallback: 'کارمند',
                              )
                            : 'کارمند',
                      )
                    else
                      RtcInfoRow(
                        label: S.current.email,
                        value: profile?.email ?? '',
                      ),
                  ],
                ),
                if (!employee) ...[
                  RtcInfoSection(
                    title: S.current.locationInformation,
                    icon: 'assets/images/workspace_store.svg',
                    children: [
                      RtcInfoRow(
                        label: S.current.province,
                        value: profile?.province?.name ?? '',
                      ),
                      RtcInfoRow(
                        label: S.current.city,
                        value: profile?.city?.name ?? '',
                      ),
                      RtcInfoRow(
                        label: S.current.workshopCode,
                        value: profile?.insuranceId ?? '',
                      ),
                      RtcInfoRow(
                        label: S.current.postalCodeLabel,
                        value: state.postalCode,
                      ),
                      RtcInfoRow(
                        label: S.current.address,
                        value: profile?.address ?? '',
                        multiline: true,
                      ),
                    ],
                  ),
                  RtcInfoSection(
                    title: S.current.financialCreditInformation,
                    icon: 'assets/images/workspace_money_transfer_home.svg',
                    children: [
                      RtcInfoRow(
                        label: S.current.walletCreditLimit,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              CurrencyFormatter.format(
                                profile?.creditLimit ?? 0,
                              ),
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.workspaceTextStrong,
                                  ),
                            ),
                            const SizedBox(width: 4),
                            const RtcImage(
                              image: 'assets/images/rial.svg',
                              width: 24,
                              height: 24,
                              boxFit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  RtcInfoSection(
                    title: S.current.organizationInformation,
                    icon: 'assets/images/workspace_representative.svg',
                    children: [
                      RtcInfoRow(
                        label: S.current.regionalManager,
                        value:
                            '${profile?.manager?.firstName ?? ''} ${profile?.manager?.lastName ?? ''}'
                                .trim(),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    },
  );
}

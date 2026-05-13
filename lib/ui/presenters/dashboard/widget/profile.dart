import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_appbar.dart';
import 'package:rtc_mobile/ui/widget/rtc_credit_limit_field.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_field.dart';
import '../../../../generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const ProfileScreen({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RtcAppBar(
        title: S.current.profile,
        onBack: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.dashboard);
          }
        },
        backIconPath: "$baseImage/angle-right.svg",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                spacing: 12,
                children: [
                  RtcTextField(
                    labelText: S.current.phoneNumber,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['phoneNumber'] ?? '۰۹۱۲۶۰۲۴۱۷۹',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.nationalId,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['nationalId'] ?? '۰۰۸۱۲۳۴۵۶۷',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.email,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['email'] ?? 'Arash.fardad@gmail.com',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.agencyCode,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['agencyCode'] ?? 'AG-TEH-011',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.workshopCode,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['workshopCode'] ?? '۱۲۳۴۵۶۷۸۹۰',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.province,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['province'] ?? 'تهران',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.city,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['city'] ?? 'تهران',
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.address,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    maxLines: 3,
                    controller: TextEditingController(
                      text:
                          userData?['address'] ??
                          'خ ولیعصر، خ پسیان، ک طلوعی، پ ۱۵۸، واحد ۱۲ خ ولیعصر، خ پسیان، ک طلوعی، پ ۱۵۸، واحد ۱۲',
                    ),
                  ),
                  RtcCreditLimitField(
                    labelText: S.current.creditLimit,
                    value: userData?['creditLimit'] ?? '۱۰۰,۰۰۰,۰۰۰',
                    helper: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RtcImage(
                          image: "$baseImage/alert.svg",
                          width: 14,
                          height: 14,
                          color: AppColors.grayPalette.shade600,
                        ),

                        Text(
                          S.current.creditLimitHelper,
                          style: theme.bodyMedium!.copyWith(
                            color: AppColors.grayPalette.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RtcTextField(
                    labelText: S.current.regionalManager,
                    labelStyle: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade700,
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: userData?['regionalManager'] ?? 'پاشا نیکچی',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        // Background Doodle
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$baseImage/banner.png'),

              fit: BoxFit.cover,
            ),
          ),
        ),
        // Profile Info
        Positioned(
          bottom: -60,
          right: 16,
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: RtcImage(
                  image: userData?['avatarUrl'] ?? '$baseImage/Avatar.png',
                  width: 96,
                  height: 96,
                  isCircle: true,
                  circleWidth: 96,
                  circleHeight: 96,
                  boxFit: BoxFit.fill,
                ),
              ),
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userData?['fullName'] ?? 'آرش فرداد',
                    style: theme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  Text(
                    userData?['role'] ?? 'نماینده فروش',
                    style: theme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

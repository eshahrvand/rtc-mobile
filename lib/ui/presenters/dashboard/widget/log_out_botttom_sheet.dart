import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_icon_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

import '../../../../config/config.dart';
import '../../../../data_source/local/prefs/prefs.dart';
import '../../../../locator.dart';

void showLogOutBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext bottomSheetContext) {
      var theme = Theme.of(context).textTheme;

      return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 2,
                      width: 32,
                      color: AppColors.brandPalette.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RtcImage(
                            image: "$baseImage/door_close.svg",
                            color: AppColors.grayPalette.shade800,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text("خروج", style: theme.labelLarge!.copyWith()),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RtcImage(
                          image: '$baseImage/close.svg',
                          width: 20,
                          height: 20,
                          color: AppColors.grayPalette.shade800,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "آیا از خروج از حساب کاربری خود اطمینان دارید؟",
                    style: theme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: RtcButton(
                          title: "بازگشت",
                          borderColor: AppColors.grayPalette.shade300,
                          backgroundColor: Colors.white,

                          size: RtcButtonSize.medium,
                          styleBtn: theme.labelLarge!.copyWith(
                            color: AppColors.grayPalette.shade700,
                            fontWeight: FontWeight.w600,
                          ),

                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RtcButton(
                          title: "خروج",
                          size: RtcButtonSize.medium,
                          onPressed: () {
                            _performLogOut(context);
                          },
                          styleBtn: theme.labelLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: AppColors.errorPalette.shade600,
                          borderColor: AppColors.errorPalette.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void _performLogOut(BuildContext context) async {
  final prefs = sl<Prefs>();
  await prefs.clear();

  if (context.mounted) {
    context.go(AppRoutes.auth);
  }
}

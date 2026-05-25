

import 'package:axino/config/constant.dart';
import 'package:axino/generated/l10n.dart';
import 'package:axino/locator.dart';
import 'package:axino/ui/presenters/widget/axino_button.dart';
import 'package:axino/ui/presenters/widget/axino_icon_button.dart';
import 'package:axino/ui/presenters/widget/axino_image.dart';
import 'package:axino/ui/router/app_route.dart';
import 'package:axino/ui/theme/colors.dart';
import 'package:axino/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data_source/local/prefs/prefs.dart';
import '../../../../data_source/repository/splash/catch_wallet_info.dart';

void logOutBottomSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor:
    isDarkMode(context) ? AppColors.grayPalette.shade900 : null,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
    builder: (BuildContext bottomSheetContext) {
      bool isDark = isDarkMode(context);
      return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Center(
                    child: Container(
                      height: 2,
                      width: 48,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AxinoImage(
                          image: '$baseImage/exit.svg',
                          color: isDark
                              ? AppColors.grayPalette.shade100
                              : AppColors.grayPalette.shade800,
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          S.current.logOut,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                              color: isDark
                                  ? AppColors.grayPalette.shade100
                                  : AppColors.grayPalette.shade800),
                        ),
                        Expanded(child: SizedBox()),
                        AxinoIconButton(
                          icon: '$baseImage/close.svg',
                          color: isDark ? AppColors.grayPalette.shade100 : null,
                          size: 20,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(S.current.logOutConfirmation,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                          color: isDark
                              ? AppColors.grayPalette.shade100
                              : AppColors.grayPalette.shade800)),
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Row(
                      children: [
                        Expanded(
                          child: AxinoButton(
                            title: S.current.logOut,
                            size: AxinoButtonSize.medium,
                            onPressed: () {
                              logOut(context);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: AxinoButton(
                            title: S.current.back,
                            backgroundColor: isDark
                                ? AppColors.grayPalette.shade900
                                : Colors.white,
                            size: AxinoButtonSize.medium,
                            styleBtn: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.primaryDark),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

void logOut(BuildContext context) async {
  await Preferences.clear();
  final walletCache = locator.get<WalletCache>();
  walletCache.clearAll();
  context.pushReplacement(AppRoutes.auth);
}

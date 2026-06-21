import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../../data_source/remote/profile/model/user_profile_dto_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

Widget profileHeader(BuildContext context, UserProfileDtoModel? userProfile) {
  var theme = Theme.of(context).textTheme;

  return Stack(
    alignment: Alignment.bottomRight,
    clipBehavior: Clip.none,
    children: [
      // Background Doodle
      Container(
        height: 140,
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
        bottom: -75,
        right: 16,
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                image: userProfile?.avatar?.file ?? '$baseImage/Avatar.png',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  userProfile != null
                      ? '${userProfile!.firstName} ${userProfile!.lastName}'
                      : '',
                  style: theme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
                Text(
                  userProfile?.agentType == 'natural'
                      ? S.current.naturalAgent
                      : S.current.legalAgent,
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

// import 'package:axino/config/constant.dart';
// import 'package:axino/ui/presenters/widget/axino_image.dart';
// import 'package:axino/ui/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:axino/ui/theme/colors.dart';
//
// import '../ui/theme/colors.dart';
//
// AppBar appBar(
//   BuildContext context, {
//   String? title,
//   Function? onBack,
//   String? backIcon,
//   double? elevation,
//   // Color? backgroundColor,
//   List<Widget>? action,
//   PreferredSize? bottom,
// }) {
//   return AppBar(
//     shadowColor: AppColors.shadowColor.withOpacity(0.15),
//     surfaceTintColor: AppColors.grayPalette.shade50,
//     backgroundColor:
//         isDarkMode(context) ? AppColors.darkBackGroundColor : Colors.white,
//     actions: action ?? [],
//     title: Text(
//       title ?? "",
//       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//           color: isDarkMode(context)
//               ? AppColors.grayPalette.shade100
//               : AppColors.grayPalette.shade800),
//     ),
//     leadingWidth: onBack != null ? 60 : null,
//     leading: onBack != null
//         ? Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: GestureDetector(
//               onTap: () => onBack(),
//               child: backIcon != null
//                   ? AxinoImage(
//                       image: backIcon,
//                       color: isDarkMode(context)
//                           ? AppColors.grayPalette.shade100
//                           : null,
//                     )
//                   : AxinoImage(
//                       image: '$baseImage/close.svg',
//                       color: isDarkMode(context) ? Colors.white : null,
//                     ),
//             ),
//           )
//         : SizedBox(
//             width: 0,
//             height: 0,
//           ),
//     elevation: isDarkMode(context) ? 0 : elevation ?? 0,
//     centerTitle: true,
//     bottom: bottom,
//   );
// }

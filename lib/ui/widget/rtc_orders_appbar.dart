import 'package:flutter/material.dart';
import '../presenters/orders/bloc/orders_cubit.dart';
import 'rtc_image.dart';
import 'rtc_text_field.dart';
import 'package:rtc_mobile/config/config.dart';

class RtcOrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchActive;
  final String searchQuery;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final OrdersCubit cubit;

  const RtcOrdersAppBar({
    super.key,
    required this.isSearchActive,
    required this.searchQuery,
    required this.scaffoldKey,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearchActive) {
      return AppBar(
        // TODO: replace with theme color
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => cubit.onSearchChanged(''), // Clear search
          icon: RtcImage(image: '$baseImage/close.svg', width: 24, height: 24),
        ),
        title: RtcTextField(
          autoFocus: true,
          labelText: 'جستجو در سفارشات',
          onChanged: (value) => cubit.onSearchChanged(value),
          suffix: RtcImage(
            image: '$baseImage/search.svg',
            width: 20,
            height: 20,
          ),
        ),
      );
    }

    return AppBar(
      // TODO: replace with theme color
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => cubit.onSearchChanged(' '), // Trigger search state
        icon: RtcImage(
          image: '$baseImage/search.svg',
          width: 24,
          height: 24,
        ),
      ),
      title: const Text(
        'سفارشات',
        style: TextStyle(
          // TODO: replace with AppTextStyle
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          icon: RtcImage(
            image: '$baseImage/drawer_menu.svg',
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

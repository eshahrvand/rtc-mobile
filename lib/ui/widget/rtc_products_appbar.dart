import 'package:flutter/material.dart';
import '../presenters/products/bloc/product_cubit.dart';
import 'rtc_image.dart';
import 'rtc_text_field.dart';
import 'package:rtc_mobile/config/config.dart';
import '../../../generated/l10n.dart';

class RtcProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchActive;
  final String searchQuery;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ProductCubit cubit;

  const RtcProductsAppBar({
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
          onPressed: () => cubit.deactivateSearch(),
          icon: RtcImage(image: '$baseImage/close.svg', width: 24, height: 24),
        ),
        title: RtcTextField(
          autoFocus: true,
          hintText: S.current.searchProducts,
          onChanged: (value) => cubit.onSearchChanged(value),
          prefix: RtcImage(
            image: '$baseImage/search.svg', // Placeholder
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
        onPressed: () => cubit.activateSearch(),
        icon: RtcImage(
          image: '$baseImage/search.svg', // Placeholder
          width: 24,
          height: 24,
        ),
      ),
      title: Text(
        S.current.products,
        style: const TextStyle(
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

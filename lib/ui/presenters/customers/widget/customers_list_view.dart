import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/customers_cubit.dart';
import '../bloc/customers_state.dart';

import 'customers_ui_helpers.dart';

class CustomersListView extends StatefulWidget {
  const CustomersListView({super.key});

  @override
  State<CustomersListView> createState() => _CustomersListViewState();
}

class _CustomersListViewState extends State<CustomersListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        // Sync controller with state (e.g. when cleared from outside)
        if (_searchController.text != state.searchQuery) {
          _searchController.text = state.searchQuery;
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: RtcTextField(
                controller: _searchController,
                hintText: S.current.search,
                hintStyle: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade400,
                ),
                onChanged: (value) =>
                    context.read<CustomersCubit>().onSearchChanged(value),
                prefix: RtcImage(image: "$baseImage/search.svg"),
                suffix: state.searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          context.read<CustomersCubit>().onSearchChanged('');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: RtcImage(
                              image: "$baseImage/close.svg",
                              width: 20.0,
                              height: 20.0,
                              boxFit: BoxFit.fill,
                              color: AppColors.grayPalette.shade700),
                        ),
                      )
                    : null,
              ),
            ),
            Expanded(
              child: CustomersUiHelpers.resolveListBody(
                context: context,
                state: state,
                theme: theme,
              ),
            ),
          ],
        );
      },
    );
  }
}

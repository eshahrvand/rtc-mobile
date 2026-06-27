import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_field.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep2Header extends StatelessWidget {
  final TextEditingController searchController;
  final PreInvoiceState state;
  final PreInvoiceCubit cubit;
  final VoidCallback onSortTap;
  final VoidCallback onSearchCleared;

  const PreInvoiceStep2Header({
    super.key,
    required this.searchController,
    required this.state,
    required this.cubit,
    required this.onSortTap,
    required this.onSearchCleared,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: RtcTextField(
                controller: searchController,
                hintText: S.current.searchHint,
                hintStyle: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade400,
                ),
                onChanged: (value) => cubit.onSearchChanged(value),
                prefix: RtcImage(
                  image: "$baseImage/search.svg",
                  boxFit: BoxFit.contain,
                  width: 20,
                  height: 20,
                ),
                suffix: searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: onSearchCleared,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: RtcImage(
                            image: "$baseImage/close.svg",
                            width: 20,
                            height: 20,
                            boxFit: BoxFit.fill,
                            color: AppColors.grayPalette.shade700,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            GestureDetector(
              onTap: onSortTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: state.selectedSortOrder != null
                      ? AppColors.brandPalette.shade50
                      : AppColors.grayPalette.shade25,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: state.selectedSortOrder != null
                        ? AppColors.brandPalette.shade200
                        : AppColors.grayPalette.shade200,
                  ),
                ),
                child: RtcImage(
                  image: "$baseImage/sort.svg",
                  color: state.selectedSortOrder != null
                      ? AppColors.brandPalette.shade600
                      : AppColors.grayPalette.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreInvoiceStep2AvailabilityToggle extends StatelessWidget {
  final bool showAvailableOnly;
  final VoidCallback onToggle;

  const PreInvoiceStep2AvailabilityToggle({
    super.key,
    required this.showAvailableOnly,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: RtcImage(
            image: showAvailableOnly
                ? "$baseImage/toggle_active.svg"
                : "$baseImage/toggle_base.svg",
            width: 36,
            height: 20,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "نمایش کالاهای موجود",
          style: theme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
      ],
    );
  }
}

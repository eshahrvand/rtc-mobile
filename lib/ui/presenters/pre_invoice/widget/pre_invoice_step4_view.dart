import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep4View extends StatelessWidget {
  const PreInvoiceStep4View({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.mandatoryDocument,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      S.current.nationalCardFront,
                      style: theme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildUploadBox(
                      context,
                      path: state.mandatoryDocPath,
                      onTap: () => cubit.pickMandatoryDoc(),
                      onRemove: () => cubit.removeMandatoryDoc(),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      S.current.optionalDocuments,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildUploadBox(
                      context,
                      path: state.optionalDocPath,
                      onTap: () => cubit.pickOptionalDoc(),
                      onRemove: () => cubit.removeOptionalDoc(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUploadBox(
    BuildContext context, {
    String? path,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: path == null ? onTap : null,
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grayPalette.shade25,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayPalette.shade200, width: 1),
        ),
        child: path == null
            ? Column(
                children: [
                  SizedBox(height: 14),
                  RtcImage(
                    image: "$baseImage/featured-icon.svg",
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: S.current.clickToUpload.split(
                            'بارگذاری عکس',
                          )[0],
                        ),
                        TextSpan(
                          text: 'بارگذاری عکس ',
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(color: AppColors.brandPalette.shade600),
                        ),
                        TextSpan(
                          text: S.current.clickToUpload.split(
                            'بارگذاری عکس',
                          )[1],
                        ),
                      ],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade700,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.current.uploadFormatInfo,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      path,
                      // Using asset for simulation, should be File(path) in real usage
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: RtcImage(
                        image: "$baseImage/delete-image.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:ui';

import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_button.dart';
import 'package:rtc_mobile/core/utils/file_utils.dart';
import 'package:rtc_mobile/ui/presenters/orders/widget/document_viewer_screen.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_document_item.dart';

import 'pre_invoice_step4_widgets.dart';

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
                    PreInvoiceStep4UploadBox(
                      xFile: state.mandatoryDoc,
                      onTap: () => cubit.pickMandatoryDoc(context),
                      onRemove: () => cubit.removeMandatoryDoc(),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.optionalDocuments,
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.grayPalette.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (state.optionalDocs.isNotEmpty)
                          RtcTextButton(
                            onPressed: () => cubit.pickOptionalDoc(context),
                            title: S.current.add,
                            leftIcon: "$baseImage/plus.svg",
                            leftIconColor: AppColors.brandPalette.shade600,
                            styleBtn: theme.labelLarge!.copyWith(
                              color: AppColors.brandPalette.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...state.optionalDocs.asMap().entries.map((entry) {
                      int index = entry.key;
                      final doc = entry.value;
                      return PreInvoiceDocumentItem(
                        title: S.current.otherDocumentsLabel(index + 1),
                        fileName: doc.name,
                        fileSize: '...', // We can't easily do async here without a widget change
                        onDelete: () => cubit.removeOptionalDoc(index),
                        onView: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocumentViewerScreen(
                                url: doc.path,
                                title: S.current.otherDocumentsLabel(index + 1),
                                isLocalFile: true,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    if (state.optionalDocs.isEmpty)
                      PreInvoiceStep4UploadPlaceholder(
                        onTap: () => cubit.pickOptionalDoc(context),
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
}

import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_step_indicator.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep4View extends StatelessWidget {
  const PreInvoiceStep4View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            RtcStepIndicator(
              totalSteps: 5,
              currentStepIndex: 3,
              stepLabels: [
                S.current.selectCreditPlan,
                S.current.selectProducts,
                S.current.customerInfo,
                S.current.uploadDocuments,
                S.current.reviewAndSubmit,
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(S.current.mandatoryDocument, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(S.current.nationalCardFront, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 16),
                    _buildUploadBox(
                      context,
                      path: state.mandatoryDocPath,
                      onTap: () => cubit.pickMandatoryDoc(),
                      onRemove: () => cubit.removeMandatoryDoc(),
                    ),
                    const SizedBox(height: 32),
                    Text(S.current.optionalDocuments, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RtcButton(
                title: S.current.nextStep,
                isActive: state.mandatoryDocPath != null,
                onPressed: () => cubit.goToStep(PreInvoiceStep.review),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUploadBox(BuildContext context, {String? path, required VoidCallback onTap, required VoidCallback onRemove}) {
    return GestureDetector(
      onTap: path == null ? onTap : null,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: path == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.image_outlined, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: S.current.clickToUpload.split('اینجا')[0]),
                        TextSpan(text: 'اینجا ', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        TextSpan(text: S.current.clickToUpload.split('اینجا')[1]),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(S.current.uploadFormatInfo, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      path, // Using asset for simulation, should be File(path) in real usage
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

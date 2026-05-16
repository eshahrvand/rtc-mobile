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
            const RtcStepIndicator(
              totalSteps: 5,
              currentStepIndex: 3,
              stepLabels: [
                'انتخاب طرح اعتباری',
                'انتخاب کالاها',
                'اطلاعات مشتری',
                'بارگذاری مدارک',
                'بررسی نهایی و ثبت',
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('مدرک اجباری*', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('تصویر روی کارت ملی', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 16),
                    _buildUploadBox(
                      context,
                      path: state.mandatoryDocPath,
                      onTap: () => cubit.pickMandatoryDoc(),
                      onRemove: () => cubit.removeMandatoryDoc(),
                    ),
                    const SizedBox(height: 32),
                    const Text('مدارک اختیاری', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                title: 'مرحله بعد',
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
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'برای '),
                        TextSpan(text: 'بارگذاری عکس ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        TextSpan(text: 'اینجا را کلیک کنید.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('فرمت فایل: PNG, JPG | حداکثر حجم: ۱۰۰ KB', style: TextStyle(fontSize: 10, color: Colors.grey)),
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

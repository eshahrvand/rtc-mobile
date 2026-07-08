import 'package:flutter/material.dart';
import '../../../widget/rtc_button.dart';

class OrderFinancialActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const OrderFinancialActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
        child: RtcButton(
          styleBtn: theme.labelLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          title: title,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

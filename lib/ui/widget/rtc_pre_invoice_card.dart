import 'package:flutter/material.dart';
import 'rtc_image.dart';

class RtcPreInvoiceCard extends StatelessWidget {
  final VoidCallback onTap;

  const RtcPreInvoiceCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D2939), // // TODO: replace with theme values
          borderRadius: BorderRadius.circular(12), // // TODO: replace with theme values
        ),
        child: const Row(
          children: [
            RtcImage(
              image: 'assets/images/ic_arrow_left.svg',
              width: 20,
              height: 20,
              color: Colors.white, // // TODO: replace with theme values
            ),
            Spacer(),
            Text(
              'صدور پیش‌فاکتور',
              style: TextStyle(
                color: Colors.white, // // TODO: replace with theme values
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 12),
            RtcImage(
              image: 'assets/images/ic_invoice_add.svg',
              width: 24,
              height: 24,
              color: Colors.white, // // TODO: replace with theme values
            ),
          ],
        ),
      ),
    );
  }
}

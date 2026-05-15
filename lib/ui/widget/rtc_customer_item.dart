import 'package:flutter/material.dart';
import '../../data/models/customer_model.dart';
import '../theme/colors.dart';

class RtcCustomerItem extends StatelessWidget {
  final CustomerItemModel customer;
  final VoidCallback onTap;

  const RtcCustomerItem({
    super.key,
    required this.customer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // TODO: replace with theme color
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  customer.city,
                  style: const TextStyle(
                    fontSize: 14,
                    // TODO: replace with theme color
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // TODO: replace with theme color
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  customer.phoneNumber,
                  style: const TextStyle(
                    fontSize: 14,
                    // TODO: replace with theme color
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

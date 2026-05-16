import 'package:flutter/material.dart';
import '../../../../data/models/pre_invoice_model.dart';
import '../../../widget/rtc_image.dart';

class RtcPreInvoiceProductItem extends StatelessWidget {
  final PreInvoiceProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const RtcPreInvoiceProductItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _buildImage(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildAvailability(),
                const SizedBox(height: 8),
                _buildPriceAndActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RtcImage(image: product.imageUrl, boxFit: BoxFit.contain),
    );
  }

  Widget _buildAvailability() {
    return Text(
      product.isAvailable ? 'موجودی (${product.inventory})' : 'ناموجود',
      style: TextStyle(
        fontSize: 12,
        color: product.isAvailable ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildPriceAndActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCounter(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (product.oldPrice != null)
              Text(
                product.oldPrice!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            Row(
              children: [
                if (product.discount != null)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      product.discount!,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                const Text('تومان', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounter() {
    if (quantity == 0) {
      return GestureDetector(
        onTap: product.isAvailable ? onAdd : null,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: product.isAvailable ? Colors.black : Colors.grey,
            size: 20,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          GestureDetector(onTap: onAdd, child: const Icon(Icons.add, size: 18)),
          const SizedBox(width: 12),
          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 18,
              color: quantity == 1 ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

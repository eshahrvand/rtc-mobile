import 'package:flutter/material.dart';
import 'widget/products_body.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In the new IndexedStack architecture, ProductsBody is used directly.
    // This class remains for consistency or standalone usage if needed, 
    // but without Scaffold as requested.
    return const ProductsBody();
  }
}

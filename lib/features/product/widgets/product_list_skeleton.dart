import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_warungnya_warga_net/features/product/widgets/product_card.dart';

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.73,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return ProductCard(
            title: 'Loading product',
            category: 'Loading',
            price: 'Rp 0',
            imageUrl: '',
            onAddToCart: () async {},
          );
        },
      ),
    );
  }
}

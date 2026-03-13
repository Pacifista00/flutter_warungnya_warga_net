import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/product_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ProductCard(
              productId: '',
              title: 'Loading product',
              description: 'Loading description',
              price: 'Rp 0',
              imageUrl: '',
              onAddToCart: () async {},
            ),
          );
        },
      ),
    );
  }
}

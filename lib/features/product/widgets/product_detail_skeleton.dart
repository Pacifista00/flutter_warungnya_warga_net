import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Container(height: 320, width: double.infinity, color: Colors.grey),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // TITLE
                  SizedBox(
                    width: 200,
                    height: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 10),

                  // PRICE
                  SizedBox(
                    width: 120,
                    height: 18,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 20),

                  // DESCRIPTION TITLE
                  SizedBox(
                    width: 160,
                    height: 16,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 8),

                  // DESCRIPTION LINES
                  SizedBox(
                    width: double.infinity,
                    height: 14,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 6),

                  SizedBox(
                    width: double.infinity,
                    height: 14,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 6),

                  SizedBox(
                    width: 250,
                    height: 14,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ShippingDropdownSkeleton extends StatelessWidget {
  const ShippingDropdownSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skeleton title
        Container(
          width: 150,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),

        // Skeleton dropdown
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Container(
            width: 120,
            height: 16,
            color: Colors.grey.shade400, // teks placeholder
          ),
        ),
      ],
    );
  }
}

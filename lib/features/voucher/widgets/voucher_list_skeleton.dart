import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'voucher_card.dart';

class VoucherListSkeleton extends StatelessWidget {
  const VoucherListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: VoucherCard(
              title: 'Loading Voucher',
              code: 'XXXXXXX',
              description: 'Loading description',
              isActive: true,
              onUse: () {},
            ),
          );
        },
      ),
    );
  }
}

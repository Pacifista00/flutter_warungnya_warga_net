import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/reward_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RewardCardSkeleton extends StatelessWidget {
  const RewardCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: RewardCard(
              title: 'Loading reward',
              point: 0,
              imageUrl: '',
              onRedeem: () {},
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/reward_card.dart';

class RewardPointSection extends StatelessWidget {
  const RewardPointSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Tukar Poin Hadiah'),
        const SizedBox(height: 12),

        SizedBox(
          height: 170,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return RewardCard(
                title: 'Voucher Belanja 50K',
                point: 500,
                onRedeem: () {
                  debugPrint('Tukar voucher');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

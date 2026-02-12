import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/reward_card.dart';

class RewardPointSection extends StatelessWidget {
  const RewardPointSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rewards = [
      {
        "title": "Minyak Goreng 1L",
        "point": 500,
        "image": "assets/images/reward/minyak.jpg",
      },
      {
        "title": "Beras 5Kg",
        "point": 1200,
        "image": "assets/images/reward/beras.jpg",
      },
      {
        "title": "Gula 1Kg",
        "point": 300,
        "image": "assets/images/reward/gula.jfif",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Tukar Poin Hadiah'),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];

              return RewardCard(
                title: reward["title"],
                point: reward["point"],
                imageUrl: reward["image"],
                onRedeem: () {
                  debugPrint('Tukar ${reward["title"]}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

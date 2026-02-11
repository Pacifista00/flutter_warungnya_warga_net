import 'package:flutter/material.dart';

class SpecialOfferSection extends StatelessWidget {
  const SpecialOfferSection({super.key});

  final List<String> images = const [
    'assets/images/carousel/carousel1.jpg',
    'assets/images/carousel/carousel2.jpg',
    'assets/images/carousel/carousel3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}

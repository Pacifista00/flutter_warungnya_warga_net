import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final int point;
  final String imageUrl;
  final VoidCallback onRedeem;

  const RewardCard({
    super.key,
    required this.title,
    required this.point,
    required this.imageUrl,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            SizedBox(
              height: 110, // tinggi FIX
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover, // WAJIB
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// POINT
                  Row(
                    children: [
                      const Icon(
                        Icons.stars,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$point Poin',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onRedeem,
                      child: const Text(
                        'Tukar Barang',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
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

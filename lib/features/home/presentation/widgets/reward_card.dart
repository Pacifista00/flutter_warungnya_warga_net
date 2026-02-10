import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final int point;
  final VoidCallback onRedeem;

  const RewardCard({
    super.key,
    required this.title,
    required this.point,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 170,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.local_offer,
                color: AppColors.primary,
                size: 24,
              ),
            ),

            const SizedBox(height: 10),

            /// TITLE
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            /// POINT
            Row(
              children: [
                const Icon(Icons.stars, size: 16, color: AppColors.secondary),
                const SizedBox(width: 4),
                Text(
                  '$point Poin',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const Spacer(),

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
                child: const Text('Tukar', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/constant/app_spacing.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SectionTitle({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (onTap != null) ...[
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: const Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onCartPressed;

  const AppAppBar({super.key, required this.title, this.onCartPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 16,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          onPressed: onCartPressed,
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

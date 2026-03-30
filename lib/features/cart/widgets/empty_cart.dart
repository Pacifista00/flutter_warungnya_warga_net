import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),

            const SizedBox(height: 16),

            const Text(
              "Keranjang Kosong",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Belum ada produk di keranjang",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: 200, // tetap bisa atur width di sini
              child: AppButton(
                text: "Mulai Belanja",
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 48,
                borderRadius: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

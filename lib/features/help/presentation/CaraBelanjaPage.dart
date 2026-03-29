import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class CaraBelanjaPage extends StatelessWidget {
  const CaraBelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Pilih produk yang ingin dibeli",
      "Tambahkan produk ke keranjang",
      "Masuk ke halaman keranjang",
      "Periksa kembali pesanan Anda",
      "Klik tombol checkout",
      "Pilih metode pembayaran",
      "Selesaikan pembayaran",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cara Belanja"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                child: Text("${index + 1}"),
              ),
              title: Text(steps[index]),
            ),
          );
        },
      ),
    );
  }
}

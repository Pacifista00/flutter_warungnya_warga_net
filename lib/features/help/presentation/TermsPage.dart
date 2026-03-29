import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Syarat & Ketentuan"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text("""
1. Penggunaan Layanan
Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi seluruh syarat dan ketentuan yang berlaku.

2. Akun Pengguna
Pengguna bertanggung jawab atas keamanan akun masing-masing.

3. Transaksi
Semua transaksi yang dilakukan bersifat final dan tidak dapat dibatalkan kecuali dalam kondisi tertentu.

4. Pembayaran
Pembayaran dilakukan melalui metode yang tersedia dan diproses secara aman.

5. Perubahan Ketentuan
Kami berhak mengubah syarat dan ketentuan sewaktu-waktu tanpa pemberitahuan terlebih dahulu.

6. Penutup
Dengan menggunakan layanan ini, Anda dianggap telah membaca dan menyetujui semua ketentuan.
          """, style: TextStyle(fontSize: 16, height: 1.6)),
      ),
    );
  }
}

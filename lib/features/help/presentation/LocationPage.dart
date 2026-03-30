import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokasi Kami"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto lokasi full layar tanpa padding
            Image.asset(
              'assets/images/gudang.jpg',
              width: screenWidth,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),

            // Teks dengan padding horizontal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Judul utama
                    Text(
                      "Lokasi Gudang Kami",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Deskripsi
                    const Text(
                      "Kami berlokasi di pusat kota, mudah dijangkau dengan transportasi umum maupun kendaraan pribadi. "
                      "Silakan kunjungi kami selama jam operasional untuk informasi lebih lanjut atau layanan langsung.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Alamat
                    const Text(
                      "Alamat:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Jl. Contoh No. 123, Kecamatan Contoh, Kota Contoh, 12345",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Kontak
                    const Text(
                      "Kontak:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Telepon: (021) 12345678\nEmail: warungnyawarga@gmail.com",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

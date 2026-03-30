import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqData = [
      {
        "title": "Umum",
        "items": [
          {
            "q": "Apa itu layanan ini?",
            "a":
                "Kami adalah platform e-commerce yang menyediakan berbagai kebutuhan Anda mulai dari kebutuhan sehari-hari hingga barang pilihan berkualitas.",
          },
          {
            "q": "Apakah layanan ini gratis digunakan?",
            "a":
                "Ya, Anda dapat mengakses seluruh halaman dan fitur secara gratis. Namun, pembelian produk berbayar.",
          },
        ],
      },
      {
        "title": "Pembayaran",
        "items": [
          {
            "q": "Metode pembayaran apa saja yang tersedia?",
            "a":
                "Kami mendukung transfer bank, e-wallet (OVO, GoPay, Dana), kartu kredit, dan pembayaran melalui gerai retail.",
          },
          {
            "q": "Apakah pembayaran aman?",
            "a": "Seluruh transaksi menggunakan Midtrans Payment Gateway.",
          },
          {
            "q": "Bisakah saya membayar ketika barang sampai?",
            "a":
                "Tidak, Cash on Delivery (COD) belum tersedia untuk toko kami.",
          },
        ],
      },
      {
        "title": "Pengiriman",
        "items": [
          {
            "q": "Berapa lama proses pengiriman?",
            "a":
                "Estimasi pengiriman 1–3 hari untuk wilayah Jabodetabek dan 2–7 hari untuk wilayah lainnya.",
          },
          {
            "q": "Jasa ekspedisi apa yang digunakan?",
            "a": "Kami bekerja sama dengan JNE dan J&T.",
          },
          {
            "q": "Bagaimana cara melacak pesanan saya?",
            "a":
                "Setelah pesanan dikirim, Anda akan menerima nomor resi yang dapat dilacak melalui halaman tracking.",
          },
        ],
      },
      {
        "title": "Akun",
        "items": [
          {
            "q": "Bagaimana cara membuat akun?",
            "a": "Anda cukup mendaftar menggunakan email aktif",
          },
          {
            "q": "Saya lupa password. Apa yang harus saya lakukan?",
            "a": "Hubungi admin untuk mereset kata sandi.",
          },
          {
            "q": "Apakah saya bisa menghapus akun?",
            "a": "Tidak, Anda tidak dapat menghapus akun.",
          },
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 Title
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Temukan jawaban dari pertanyaan yang paling sering ditanyakan.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            /// 🔹 Sections
            ...faqData.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Section Title (garis kiri biru)
                  Row(
                    children: [
                      Container(width: 4, height: 20, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        section["title"] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Items
                  ...(section["items"] as List).map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(
                          14,
                          0,
                          14,
                          14,
                        ),
                        shape: const Border(),
                        collapsedShape: const Border(),
                        title: Text(
                          item["q"] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        iconColor: Colors.black,
                        collapsedIconColor: Colors.black,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item["a"] as String,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

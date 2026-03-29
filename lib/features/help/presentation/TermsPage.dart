import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  final String waNumber = "6281234567890"; // ganti dengan nomor WA
  final String waMessage =
      "Halo, saya butuh bantuan terkait syarat & ketentuan";
  final String appName = "Warungnya Warga Net"; // ganti dengan nama aplikasi

  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/$waNumber?text=${Uri.encodeComponent(waMessage)}",
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  Widget _subHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _subHeading2(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
    );
  }

  Widget _bulletList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            items
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "• ",
                          style: TextStyle(fontSize: 14, height: 1.5),
                        ),
                        Expanded(
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _paragraph(
              "Syarat dan Ketentuan ini mengatur penggunaan layanan pada $appName. "
              "Dengan mengakses, menggunakan, atau melakukan transaksi di aplikasi ini, "
              "Anda menyatakan telah membaca, memahami, dan menyetujui seluruh ketentuan yang berlaku. "
              "Jika Anda tidak menyetujui bagian dari ketentuan ini, mohon untuk tidak menggunakan layanan $appName.",
            ),

            // 1. Ketentuan Umum
            _subHeading2("1. Ketentuan Umum"),
            _paragraph(
              "$appName adalah platform perdagangan online yang menyediakan berbagai jenis produk. "
              "Pengguna setuju untuk tidak menggunakan layanan untuk tujuan ilegal, merusak, atau melanggar hukum. "
              "Semua aktivitas yang dilakukan melalui akun pengguna menjadi tanggung jawab masing-masing pengguna.",
            ),

            // 2. Kelayakan & Umur Pengguna
            _subHeading2("2. Kelayakan & Batas Usia Pengguna"),
            _paragraph(
              "Layanan $appName hanya boleh digunakan oleh individu berusia minimal 18 tahun atau telah dianggap dewasa berdasarkan hukum yang berlaku. "
              "Jika Anda berusia di bawah 18 tahun, Anda harus menggunakan layanan di bawah pengawasan orang tua atau wali.",
            ),

            // 3. Pendaftaran Akun
            _subHeading2("3. Pendaftaran Akun"),
            _bulletList([
              "Pengguna wajib memberikan informasi yang benar, valid, dan terbaru.",
              "Pengguna bertanggung jawab penuh terhadap kerahasiaan akun dan password.",
              "Segala aktivitas yang terjadi melalui akun pengguna dianggap sebagai aktivitas pengguna sendiri.",
              "$appName berhak menonaktifkan akun yang melanggar ketentuan atau dicurigai melakukan penyalahgunaan.",
            ]),

            // 4. Informasi Produk & Harga
            _subHeading2("4. Informasi Produk & Harga"),
            _paragraph(
              "$appName berusaha memberikan informasi produk yang akurat dan terbaru. Namun demikian, pengguna memahami bahwa:",
            ),
            _bulletList([
              "Gambar produk mungkin berbeda karena pencahayaan atau tampilan layar.",
              "Harga dapat berubah sewaktu-waktu tanpa pemberitahuan.",
              "Ketersediaan stok dapat berubah secara real-time dan tidak selalu mencerminkan keadaan terbaru.",
            ]),

            // 5. Pemesanan & Konfirmasi Transaksi
            _subHeading2("5. Pemesanan & Konfirmasi Transaksi"),
            _bulletList([
              "Pemesanan dianggap valid setelah pembayaran terverifikasi.",
              "$appName berhak membatalkan pesanan apabila ditemukan kesalahan harga, kesalahan sistem, atau indikasi penipuan.",
              "Apabila pesanan dibatalkan oleh $appName, dana akan dikembalikan 100% ke customer.",
            ]),

            // 6. Pembayaran
            _subHeading2("6. Pembayaran"),
            _paragraph(
              "Pembayaran hanya dapat dilakukan melalui metode yang tersedia pada aplikasi. Pengguna wajib memastikan nominal pembayaran sesuai dengan instruksi transaksi.",
            ),
            _bulletList([
              "Pembayaran yang tidak sesuai menyebabkan pesanan otomatis gagal.",
              "$appName tidak bertanggung jawab atas kesalahan transfer dana.",
              "Bukti pembayaran wajib disimpan untuk keperluan verifikasi.",
            ]),

            // 7. Pengiriman
            _subHeading2("7. Pengiriman"),
            _bulletList([
              "Estimasi pengiriman berbeda tergantung lokasi, beban kerja kurir, dan kondisi eksternal.",
              "Risiko kehilangan atau kerusakan barang setelah diserahkan ke kurir menjadi tanggung jawab pihak logistik.",
              "Pengguna wajib memastikan alamat pengiriman benar dan lengkap.",
            ]),

            // 8. Garansi Produk
            _subHeading2("8. Garansi Produk"),
            _paragraph(
              "Tidak semua produk memiliki garansi. Pengguna wajib membaca informasi garansi sebelum melakukan pembelian.",
            ),

            // 9. Pengembalian & Refund
            _subHeading2("9. Pengembalian Barang (Retur) & Refund"),
            _paragraph(
              "Pengembalian barang hanya dapat dilakukan apabila memenuhi syarat:",
            ),
            _bulletList([
              "Produk rusak bukan karena kesalahan pengguna.",
              "Kemasan, label, dan kelengkapan masih utuh.",
              "Pengajuan dilakukan maksimal 3×24 jam setelah barang diterima.",
              "Produk tidak boleh dalam kondisi digunakan.",
              "Menyertakan video bukti unboxing saat membuka paket.",
            ]),

            // 10. Hak Kekayaan Intelektual
            _subHeading2("10. Hak Kekayaan Intelektual"),
            _paragraph(
              "Seluruh konten pada aplikasi ini seperti teks, desain, logo, ikon, gambar, struktur, dan perangkat lunak dilindungi oleh hukum Hak Kekayaan Intelektual. "
              "Pengguna dilarang menyalin, mendistribusikan, atau memanfaatkan konten tanpa izin tertulis dari $appName.",
            ),

            // 11. Aktivitas Terlarang
            _subHeading2("11. Aktivitas yang Dilarang"),
            _bulletList([
              "Mengunggah konten yang melanggar hukum.",
              "Mencoba meretas atau mengganggu server $appName.",
              "Membuat pesanan palsu atau spam transaksi.",
              "Menyalahgunakan voucher, promo, atau sistem reward.",
            ]),

            // 12. Pembatasan Tanggung Jawab
            _subHeading2("12. Pembatasan Tanggung Jawab"),
            _paragraph(
              "$appName tidak bertanggung jawab atas kerugian langsung, tidak langsung, insidental, atau konsekuensial yang timbul dari penggunaan aplikasi, termasuk kehilangan data, keuntungan, atau kerusakan akibat penundaan layanan pihak ketiga.",
            ),

            // 13. Force Majeure
            _subHeading2("13. Force Majeure"),
            _paragraph(
              "$appName dibebaskan dari tanggung jawab apabila terjadi kegagalan layanan akibat keadaan di luar kendali seperti bencana alam, perang, gangguan listrik, kebijakan pemerintah, atau serangan siber.",
            ),

            // 14. Perubahan Syarat & Ketentuan
            _subHeading2("14. Perubahan Syarat & Ketentuan"),
            _paragraph(
              "$appName berhak mengubah Syarat dan Ketentuan tanpa pemberitahuan sebelumnya. Pengguna diharapkan memeriksa halaman ini secara berkala untuk mengetahui pembaruan terbaru.",
            ),

            // 15. Penyelesaian Sengketa
            _subHeading2("15. Penyelesaian Sengketa"),
            _paragraph(
              "Setiap perselisihan akan diselesaikan terlebih dahulu melalui musyawarah. Jika tidak tercapai kesepakatan, sengketa akan diselesaikan sesuai hukum yang berlaku di Indonesia.",
            ),

            // 16. Kontak
            _subHeading2("16. Kontak"),
            _paragraph(
              "Jika Anda memiliki pertanyaan mengenai Syarat & Ketentuan ini, silakan hubungi layanan pelanggan melalui tombol di bawah.",
            ),

            // Button WA
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _openWhatsApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Hubungi Kami",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

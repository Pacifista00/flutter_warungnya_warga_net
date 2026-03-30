import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CaraBelanjaPage extends StatelessWidget {
  const CaraBelanjaPage({super.key});

  Future<void> _openWhatsApp() async {
    const phone = "6281234567890";
    const message = "Halo, saya butuh bantuan terkait pesanan";

    final url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    await launchUrl(
      url,
      mode:
          LaunchMode.inAppBrowserView, // ✅ buka di browser (Chrome Custom Tabs)
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        "icon": Icons.person_outline,
        "title": "1. Buat / Masuk Akun",
        "desc":
            "Untuk melakukan pemesanan, Anda harus membuat akun terlebih dahulu kemudian login menggunakan email anda.",
      },
      {
        "icon": Icons.shopping_cart_outlined,
        "title": "2. Pilih Produk",
        "desc":
            "Telusuri produk, baca detailnya, lalu klik tombol “Tambah ke Keranjang”.",
      },
      {
        "icon": Icons.shopping_cart,
        "title": "3. Periksa Keranjang",
        "desc":
            "Pastikan produk, jumlah, dan harga sudah sesuai sebelum checkout.",
      },
      {
        "icon": Icons.location_on_outlined,
        "title": "4. Isi Alamat",
        "desc":
            "Tambahkan alamat lengkap dan jadikan alamat default di profil.",
      },
      {
        "icon": Icons.local_shipping_outlined,
        "title": "5. Pilih Pengiriman",
        "desc": "Pilih metode pengiriman yang Anda inginkan.",
      },
      {
        "icon": Icons.credit_card,
        "title": "6. Pilih Pembayaran",
        "desc":
            "Anda akan diarahkan ke halaman Midtrans untuk menyelesaikan transaksi.",
      },
      {
        "icon": Icons.check_circle,
        "title": "7. Pembayaran Berhasil",
        "desc":
            "Setelah pembayaran berhasil, pesanan Anda akan segera diproses.",
      },
      {
        "icon": Icons.local_shipping,
        "title": "8. Pesanan Dikirim",
        "desc": "Barang akan dikirim dan Anda akan menerima nomor resi.",
      },
    ];

    final payments = [
      {
        "icon": Icons.account_balance,
        "title": "Virtual Account (VA)",
        "desc":
            "Pembayaran melalui BCA, BNI, BRI, Mandiri, dll via ATM atau m-banking.",
      },
      {
        "icon": Icons.account_balance_wallet_outlined,
        "title": "E-Wallet",
        "desc": "Dukungan GoPay, OVO, Dana, LinkAja. Praktis dan cepat.",
      },
      {
        "icon": Icons.qr_code_scanner,
        "title": "QRIS",
        "desc": "Scan QR dengan aplikasi bank atau e-wallet apa pun.",
      },
      {
        "icon": Icons.credit_card,
        "title": "Kartu Kredit / Debit",
        "desc": "Pembayaran dengan Visa, MasterCard melalui Midtrans.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cara Belanja"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Header
          const Center(
            child: Text(
              "Cara Belanja",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Ikuti langkah-langkah berikut untuk melakukan pemesanan dengan mudah dan aman.",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          /// STEP LIST
          ...steps.map((step) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(step["icon"] as IconData, color: Colors.blue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step["title"] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(step["desc"] as String),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 20),

          /// PAYMENT SECTION
          const Text(
            "Metode Pembayaran (Midtrans)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          const Text(
            "Kami menggunakan Midtrans sebagai gateway pembayaran yang aman dan terpercaya.",
          ),
          const SizedBox(height: 12),

          ...payments.map((p) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(p["icon"] as IconData, color: Colors.orange),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p["title"] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(p["desc"] as String),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 20),

          /// INFO PENTING
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.yellow.shade50,
              border: const Border(
                left: BorderSide(color: Colors.orange, width: 4),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Penting",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("• Pesanan dibatalkan jika tidak dibayar dalam 1 jam"),
                Text("• Data kartu tidak disimpan oleh sistem"),
                Text("• Verifikasi pembayaran 1–3 menit"),
                Text("• Hubungi kami jika ada kendala"),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String orderId;

  const PaymentSuccessPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pembayaran Berhasil"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ICON SUCCESS
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 70),
            ),

            const SizedBox(height: 24),

            /// TITLE
            const Text(
              "Pembayaran Berhasil!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// SUBTITLE
            const Text(
              "Terima kasih! Pesanan Anda sedang diproses oleh penjual.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 40),

            /// BUTTON LIHAT PESANAN
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: "Lihat Pesanan",
                onPressed: () {
                  context.pushReplacement("/orders/detail/$orderId");
                },
              ),
            ),

            const SizedBox(height: 12),

            /// BUTTON KEMBALI KE BERANDA
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: "Kembali ke Beranda",
                onPressed: () {
                  context.pushReplacement("/");
                },
                backgroundColor: Colors.white,
                textColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

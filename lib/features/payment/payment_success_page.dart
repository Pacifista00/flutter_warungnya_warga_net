import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pembayaran Berhasil")),
      body: const Center(
        child: Text("Pembayaran berhasil 🎉", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

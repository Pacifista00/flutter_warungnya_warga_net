import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/cart_item_card.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/footer_checkout.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/order_summary.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CartItemCard(),
          CartItemCard(),
          CartItemCard(),

          // 👇 RINGKASAN PESANAN
          OrderSummaryCard(),
        ],
      ),
      bottomNavigationBar: const CartFooter(),
    );
  }
}

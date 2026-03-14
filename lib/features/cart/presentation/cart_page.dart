import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/cart_item_card.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/empty_cart.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/footer_checkout.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/order_summary.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import '../models/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<CartModel> cartFuture;
  final CartService _cartService = CartService();

  int shippingCost = 0;
  int discount = 0;
  String? voucherCode;
  ShippingModel? selectedShipping;

  @override
  void initState() {
    super.initState();
    cartFuture = _cartService.getCart();
  }

  void refreshCart() {
    setState(() {
      cartFuture = _cartService.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<CartModel>(
        future: cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat keranjang'));
          }

          final cart = snapshot.data!;

          if (cart.items.isEmpty) {
            return const EmptyCartWidget();
          }

          final subtotal = cart.items.fold(
            0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          final total = subtotal + shippingCost - discount;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...cart.items.map(
                      (item) => CartItemCard(item: item, onUpdate: refreshCart),
                    ),

                    OrderSummaryCard(
                      cartItems: cart.items,
                      shippingCost: shippingCost,
                      discount: discount,
                      onShippingChanged: (shipping) {
                        setState(() {
                          selectedShipping = shipping;
                          shippingCost = shipping.price;
                        });
                      },
                      onVoucherApplied: (disc, code) {
                        setState(() {
                          discount = disc;
                          voucherCode = code;
                        });
                      },
                    ),
                  ],
                ),
              ),

              CartFooter(
                total: total,
                shipping: selectedShipping,
                voucherCode: voucherCode,
              ),
            ],
          );
        },
      ),
    );
  }
}

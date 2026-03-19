import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/midtrans_payment_page.dart';

class CartFooter extends StatefulWidget {
  final int total; // Ini sudah total bersih (Produk - Diskon + Ongkir)
  final ShippingModel? shipping;
  final String? voucherCode;
  final int pointsUsed;
  final int pointValue;

  const CartFooter({
    super.key,
    required this.total,
    this.shipping,
    this.voucherCode,
    this.pointsUsed = 0,
    this.pointValue = 5000,
  });

  @override
  State<CartFooter> createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  bool loading = false;

  String _format(int value) =>
      "Rp ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}";

  @override
  Widget build(BuildContext context) {
    final bool disabled = widget.shipping == null || loading;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Bayar',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    _format(widget.total),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: disabled ? Colors.grey : AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: disabled ? null : () => _handleCheckout(),
                child:
                    loading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCheckout() async {
    setState(() => loading = true);
    try {
      final response = await CartService().checkout(
        courierCode: widget.shipping!.courierCode,
        courierServiceCode: widget.shipping!.courierServiceCode,
        shippingPrice: widget.shipping!.price,
        voucherCode: widget.voucherCode,
        pointsUsed: widget.pointsUsed,
      );

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => MidtransPaymentPage(
                snapToken: response["snapToken"],
                orderId: response["order_id"],
                orderNumber: response["order_number"],
              ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Checkout gagal: $e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }
}

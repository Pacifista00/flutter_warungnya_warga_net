import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';

class CartFooter extends StatefulWidget {
  final int total;
  final ShippingModel? shipping;
  final String? voucherCode;
  final int pointsUsed;

  const CartFooter({
    super.key,
    required this.total,
    this.shipping,
    this.voucherCode,
    this.pointsUsed = 0,
  });

  @override
  State<CartFooter> createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  bool loading = false;

  Future<void> checkout() async {
    if (widget.shipping == null) return;

    setState(() {
      loading = true;
    });

    final CartService service = CartService();

    try {
      await service.checkout(
        courierCode: widget.shipping!.courierCode,
        courierServiceCode: widget.shipping!.courierServiceCode,
        shippingPrice: widget.shipping!.price,
        voucherCode: widget.voucherCode,
        pointsUsed: widget.pointsUsed,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Checkout berhasil')));

      // bisa redirect ke halaman order
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Checkout gagal: $e')));
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  String format(int value) {
    return "Rp ${value.toString().replaceAllMapped(RegExp(r'\\B(?=(\\d{3})+(?!\\d))'), (match) => '.')}";
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(
                    format(widget.total),
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
                onPressed: disabled ? null : checkout,
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
}

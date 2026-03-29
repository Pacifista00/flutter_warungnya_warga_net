import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/midtrans_payment_page.dart';

class CartFooter extends StatefulWidget {
  final int total;
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

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final bool disabled =
        widget.shipping == null || loading || widget.total <= 0;

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
                    formatter.format(widget.total),
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
                onPressed: disabled ? null : _handleCheckout,
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
    // 🔒 Prevent double click
    if (loading) return;

    setState(() => loading = true);

    try {
      final response = await CartService().checkout(
        courierCode: widget.shipping!.courierCode,
        courierServiceCode: widget.shipping!.courierServiceCode,
        shippingPrice: widget.shipping!.price,
        voucherCode: widget.voucherCode,
        pointsUsed: widget.pointsUsed,
      );

      // 🔴 VALIDASI RESPONSE
      if (response["snapToken"] == null ||
          response["order_id"] == null ||
          response["order_number"] == null) {
        throw Exception("Response tidak valid dari server");
      }

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
      if (!mounted) return;

      String message = "Terjadi kesalahan, coba lagi";

      final error = e.toString().toLowerCase();

      if (error.contains("voucher")) {
        message = "Voucher tidak valid atau sudah tidak berlaku";
      } else if (error.contains("stock")) {
        message = "Stok produk tidak mencukupi";
      } else if (error.contains("shipping")) {
        message = "Pengiriman tidak valid";
      } else if (error.contains("network") || error.contains("timeout")) {
        message = "Koneksi bermasalah, coba lagi";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }
}

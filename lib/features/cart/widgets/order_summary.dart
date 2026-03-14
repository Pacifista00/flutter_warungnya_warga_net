import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/cart_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/shipping_dropdown.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/voucher_form.dart';

class OrderSummaryCard extends StatelessWidget {
  final List<CartItem> cartItems;
  final int shippingCost;
  final int discount;

  final Function(ShippingModel) onShippingChanged;
  final Function(int, String?) onVoucherApplied;

  const OrderSummaryCard({
    super.key,
    required this.cartItems,
    required this.shippingCost,
    required this.discount,
    required this.onShippingChanged,
    required this.onVoucherApplied,
  });

  int get subtotal {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shippingCost - discount;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Pesanan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          _summaryRow('Sub Total', _format(subtotal)),
          _summaryRow('Biaya Pengiriman', _format(shippingCost)),
          _summaryRow('Diskon', "- ${_format(discount)}"),

          const Divider(height: 24),

          ShippingDropdown(onChanged: onShippingChanged),

          const SizedBox(height: 16),

          VoucherForm(onApplied: onVoucherApplied),

          // const SizedBox(height: 16),

          // _summaryRow('Total', _format(total), valueColor: Colors.green),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }

  String _format(int value) {
    return "Rp ${value.toString().replaceAllMapped(RegExp(r'\\B(?=(\\d{3})+(?!\\d))'), (match) => '.')}";
  }
}

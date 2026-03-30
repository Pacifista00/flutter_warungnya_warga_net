import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/order/models/order_model.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';
import 'package:flutter_warungnya_warga_net/widgets/order_status_badge.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final firstItem = order.items.isNotEmpty ? order.items.first : null;
    final displayStatus =
        (order.shippingStatus.isNotEmpty) ? order.shippingStatus : order.status;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ORDER ID
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.orderNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 8),

                OrderStatusBadge(status: displayStatus),
              ],
            ),

            const SizedBox(height: 4),

            /// TANGGAL
            Text(
              order.createdAtFormatted,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),

            const SizedBox(height: 12),

            /// PRODUK PERTAMA
            if (firstItem != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// GAMBAR
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      firstItem.imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 20,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// INFO PRODUK
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstItem.productName,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '${firstItem.quantity} x Rp ${_formatCurrency(firstItem.unitPrice)}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 14),

            /// TOTAL + BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      'Rp ${_formatCurrency(order.totalAmount)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                IntrinsicWidth(
                  child: SizedBox(
                    height: 36,
                    child: AppButton(
                      text: 'Lihat Detail',
                      onPressed: () {
                        context.push('/orders/detail/${order.id}');
                      },
                      height: 36,
                      borderRadius: 50, // kapsul
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _formatCurrency(int value) {
  return value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}

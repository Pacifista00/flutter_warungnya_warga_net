import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import '../models/cart_model.dart';
import '../../../core/theme/app_colors.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onUpdate;

  const CartItemCard({super.key, required this.item, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final CartService _cartService = CartService();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(item.imageUrl, fit: BoxFit.cover),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 4),

                Text(
                  'Rp ${item.price}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (item.quantity <= 1) return;

                        await _cartService.updateCartItem(
                          cartItemId: item.id,
                          quantity: item.quantity - 1,
                        );

                        onUpdate();
                      },
                      child: const Icon(Icons.remove_circle_outline, size: 24),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(item.quantity.toString()),
                    ),

                    InkWell(
                      onTap: () async {
                        await _cartService.updateCartItem(
                          cartItemId: item.id,
                          quantity: item.quantity + 1,
                        );

                        onUpdate();
                      },
                      child: const Icon(Icons.add_circle_outline, size: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Hapus Produk'),
                      content: const Text(
                        'Yakin ingin menghapus produk ini dari keranjang?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);

                            await _cartService.deleteCartItem(item.id);

                            onUpdate(); // refresh cart
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

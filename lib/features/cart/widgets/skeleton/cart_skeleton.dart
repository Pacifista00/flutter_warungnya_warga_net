import 'package:flutter/material.dart';

/// Skeleton untuk item keranjang
class CartItemCardSkeleton extends StatelessWidget {
  const CartItemCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 70, height: 70, color: Colors.grey.shade300),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 120, color: Colors.grey.shade300),
                const SizedBox(height: 6),
                Container(height: 14, width: 80, color: Colors.grey.shade300),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 14,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(width: 24, height: 24, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}

/// Skeleton untuk ringkasan pesanan
class OrderSummarySkeleton extends StatelessWidget {
  const OrderSummarySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          8,
          (_) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(height: 14, color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}

/// Skeleton untuk poin
class PointsSectionSkeleton extends StatelessWidget {
  const PointsSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16, width: 120, color: Colors.grey.shade300),
          const SizedBox(height: 6),
          Container(height: 14, width: 80, color: Colors.grey.shade300),
          const SizedBox(height: 6),
          Container(height: 14, width: 60, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Container(height: 40, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}

/// Skeleton untuk dropdown shipping
class ShippingDropdownSkeleton extends StatelessWidget {
  const ShippingDropdownSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label "Pilih Pengiriman"
          Container(height: 14, width: 150, color: Colors.grey.shade300),
          const SizedBox(height: 8),
          // Dropdown box
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton untuk voucher form
class VoucherFormSkeleton extends StatelessWidget {
  const VoucherFormSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Container(height: 40, color: Colors.grey.shade300)),
          const SizedBox(width: 8),
          Container(width: 80, height: 40, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}

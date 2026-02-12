import 'package:flutter/material.dart';

class ProductSearchFilterBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterPressed;

  const ProductSearchFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06), // shadow tipis
            blurRadius: 8,
            offset: const Offset(0, 4), // 👈 shadow ke bawah
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          /// SEARCH
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                isDense: true,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// FILTER BUTTON
          InkWell(
            onTap: onFilterPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
    );
  }
}

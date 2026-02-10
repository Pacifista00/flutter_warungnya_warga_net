import 'package:flutter/material.dart';

enum SortType { terbaru, hargaTermurah, hargaTermahal }

class ProductFilterSheet extends StatefulWidget {
  final int selectedCategory;
  final SortType selectedSort;
  final Function(int, SortType) onApply;

  const ProductFilterSheet({
    super.key,
    required this.selectedCategory,
    required this.selectedSort,
    required this.onApply,
  });

  static const categories = [
    'Semua',
    'Kimia',
    'Alat',
    'Bahan',
    'Kimia',
    'Alat',
    'Bahan',
  ];

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  late int category;
  late SortType sortType;

  @override
  void initState() {
    super.initState();
    category = widget.selectedCategory;
    sortType = widget.selectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Produk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// KATEGORI
            const Text('Kategori'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(
                ProductFilterSheet.categories.length,
                (index) => ChoiceChip(
                  label: Text(ProductFilterSheet.categories[index]),
                  selected: category == index,
                  onSelected: (_) => setState(() => category = index),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// SORT
            const Text('Urutkan'),
            Column(
              children:
                  SortType.values.map((type) {
                    return RadioListTile<SortType>(
                      title: Text(_label(type)),
                      value: type,
                      groupValue: sortType,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => sortType = value);
                        }
                      },
                    );
                  }).toList(),
            ),

            const SizedBox(height: 16),

            /// ACTION
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        category = 0;
                        sortType = SortType.terbaru;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(category, sortType);
                      Navigator.pop(context);
                    },
                    child: const Text('Terapkan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _label(SortType type) {
    switch (type) {
      case SortType.terbaru:
        return 'Terbaru';
      case SortType.hargaTermurah:
        return 'Harga Termurah';
      case SortType.hargaTermahal:
        return 'Harga Termahal';
    }
  }
}

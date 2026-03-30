import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/constant/product_categories.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';

enum SortType { terbaru, hargaTermurah, hargaTermahal, namaAZ }

class ProductFilterSheet extends StatefulWidget {
  final String selectedCategory;
  final SortType selectedSort;
  final Function(String, SortType) onApply;

  const ProductFilterSheet({
    super.key,
    required this.selectedCategory,
    required this.selectedSort,
    required this.onApply,
  });

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  late String category;
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
              children: [
                /// SEMUA (manual)
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: category == '',
                  onSelected: (_) {
                    setState(() => category = '');
                  },
                ),

                /// CATEGORY DARI CONSTANT
                ...productCategories.map((cat) {
                  return ChoiceChip(
                    label: Text(cat.label),
                    selected: category == cat.slug,
                    onSelected: (_) {
                      setState(() => category = cat.slug);
                    },
                  );
                }),
              ],
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
            /// ACTION
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Reset',
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    onPressed: () {
                      setState(() {
                        category = '';
                        sortType = SortType.terbaru;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: 'Terapkan',
                    onPressed: () {
                      widget.onApply(category, sortType);
                      Navigator.pop(context);
                    },
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
      case SortType.namaAZ:
        return 'Nama (A–Z)';
    }
  }
}

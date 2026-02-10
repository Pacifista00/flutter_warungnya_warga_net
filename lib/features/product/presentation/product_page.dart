import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/bottom_nav.dart';
import 'package:flutter_warungnya_warga_net/widgets/app_app_bar.dart';
import '../widgets/product_search_filter_bar.dart';
import '../widgets/product_filter_sheet.dart';
import '../widgets/product_list.dart';
import 'package:go_router/go_router.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  String searchQuery = '';
  int selectedCategory = 0;
  SortType selectedSort = SortType.terbaru;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Produk',
        onCartPressed: () {
          context.push('/cart'); // 👈 KE SINI
        },
      ),
      body: Column(
        children: [
          ProductSearchFilterBar(
            onSearchChanged: (value) {
              setState(() => searchQuery = value);
            },
            onFilterPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder:
                    (_) => ProductFilterSheet(
                      selectedCategory: selectedCategory,
                      selectedSort: selectedSort,
                      onApply: (category, sort) {
                        setState(() {
                          selectedCategory = category;
                          selectedSort = sort;
                        });
                      },
                    ),
              );
            },
          ),
          Expanded(
            child: ProductList(
              searchQuery: searchQuery,
              selectedCategory: selectedCategory,
              selectedSort: selectedSort, // tambahin di ProductList
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}

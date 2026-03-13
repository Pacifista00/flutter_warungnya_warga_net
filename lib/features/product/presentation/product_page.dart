import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/bottom_nav.dart';
import 'package:flutter_warungnya_warga_net/widgets/app_app_bar.dart';
import '../widgets/product_search_filter_bar.dart';
import '../widgets/product_filter_sheet.dart';
import '../widgets/product_list.dart';

class ProdukPage extends StatefulWidget {
  final String initialSearch;
  final String initialCategory;
  const ProdukPage({
    super.key,
    this.initialSearch = '',
    this.initialCategory = '',
  });

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  String selectedCategory = ''; // slug
  SortType selectedSort = SortType.terbaru;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.initialSearch;
    selectedCategory = widget.initialCategory;
  }

  void _openFilterSheet() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Produk',
        onCartPressed: () {
          context.push('/cart');
        },
      ),
      body: Column(
        children: [
          ProductSearchFilterBar(
            onSearchChanged: (value) {
              setState(() => searchQuery = value);
            },
            onFilterPressed: _openFilterSheet,
          ),
          Expanded(
            child: ProductList(
              key: ValueKey(
                '$searchQuery-$selectedCategory-${selectedSort.name}',
              ),
              searchQuery: searchQuery,
              selectedCategory: selectedCategory,
              selectedSort: selectedSort,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}

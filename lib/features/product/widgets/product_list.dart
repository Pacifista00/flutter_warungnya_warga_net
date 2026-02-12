import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/product/models/product_model.dart';
import 'package:flutter_warungnya_warga_net/features/product/widgets/product_card.dart';
import 'product_filter_sheet.dart';

class ProductList extends StatefulWidget {
  final String searchQuery;
  final int selectedCategory;
  final SortType selectedSort;

  const ProductList({
    super.key,
    required this.searchQuery,
    required this.selectedCategory,
    required this.selectedSort,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ScrollController _scrollController = ScrollController();
  final ProductRemoteDatasource _datasource = ProductRemoteDatasource();

  List<ProductModel> products = [];

  int currentPage = 1;
  int lastPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          currentPage < lastPage) {
        _fetchProducts();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ProductList oldWidget) {
    if (oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.selectedCategory != widget.selectedCategory ||
        oldWidget.selectedSort != widget.selectedSort) {
      products.clear();
      currentPage = 1;
      lastPage = 1;

      _scrollController.jumpTo(0);
      _fetchProducts();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchProducts() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final result = await _datasource.getProducts(
      page: currentPage,
      search: widget.searchQuery,
      category: widget.selectedCategory,
      sort: widget.selectedSort,
    );

    setState(() {
      products.addAll(result.products);
      lastPage = result.lastPage;
      currentPage++;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty && isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return const Center(child: Text('Produk tidak ditemukan'));
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.73,
      ),
      itemCount: products.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == products.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = products[index];

        return InkWell(
          onTap: () => context.push('/product/${product.id}'),
          child: ProductCard(
            title: product.name,
            category: product.category,
            price: 'Rp ${product.price}',
            imageUrl: product.imageUrl,
            onAddToCart: () {},
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/product/widgets/product_list_skeleton.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/product/models/product_model.dart';
import 'package:flutter_warungnya_warga_net/features/product/widgets/product_card.dart';
import 'product_filter_sheet.dart';

class ProductList extends StatefulWidget {
  final String searchQuery;
  final String selectedCategory;
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
  final CartService _cartService = CartService();

  List<ProductModel> products = [];

  int currentPage = 1;
  int lastPage = 1;
  bool isLoading = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts(reset: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          currentPage <= lastPage) {
        _fetchProducts();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ProductList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.searchQuery != widget.searchQuery ||
        oldWidget.selectedCategory != widget.selectedCategory ||
        oldWidget.selectedSort != widget.selectedSort) {
      _fetchProducts(reset: true);
    }
  }

  Future<void> _fetchProducts({bool reset = false}) async {
    if (isLoading) return;

    if (reset) {
      currentPage = 1;
      lastPage = 1;
      products.clear();

      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }

    setState(() {
      isLoading = true;
      if (reset) isFirstLoad = true;
    });

    try {
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
        isFirstLoad = false;
      });
    } catch (e) {
      debugPrint("Error fetch products: $e");

      setState(() {
        isLoading = false;
        isFirstLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLoad && isLoading) {
      return const ProductListSkeleton();
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
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final product = products[index];

        return InkWell(
          onTap: () => context.push('/product/${product.id}'),
          child: ProductCard(
            title: product.name,
            category: product.category,
            price: 'Rp ${product.price}',
            imageUrl: product.imageUrl,
            onAddToCart: () async {
              try {
                await _cartService.addToCart(
                  productId: (product.id),
                  quantity: 1,
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Produk ditambahkan ke keranjang"),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
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

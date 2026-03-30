import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/cart_service.dart';
import 'package:flutter_warungnya_warga_net/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/product/models/product_model.dart';
import 'package:flutter_warungnya_warga_net/features/product/widgets/product_detail_skeleton.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';

// ================= PRODUCT DETAIL PAGE =================
class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isLoading = false;
  late Future<ProductModel> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ProductRemoteDatasource().getProductById(widget.productId);
  }

  Future<void> _handleAddToCart(String productId) async {
    setState(() => _isLoading = true);
    try {
      await CartService().addToCart(productId: productId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil ditambahkan ke keranjang'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<ProductModel>(
        future: _productFuture, // <-- pakai future yang sudah disimpan
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProductDetailSkeleton();
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat produk'));
          }

          final product = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => const Icon(Icons.image, size: 80),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp ${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Deskripsi Produk',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.category,
                        style: const TextStyle(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            text: _isLoading ? 'Loading...' : 'Tambah ke Keranjang',
            onPressed:
                _isLoading ? null : () => _handleAddToCart(widget.productId),
          ),
        ),
      ),
    );
  }
}

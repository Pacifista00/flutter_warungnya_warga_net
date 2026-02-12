import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/product/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<ProductModel>(
        future: ProductRemoteDatasource().getProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat produk'));
          }

          final product = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= IMAGE =================
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

                // ================= CONTENT =================
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // PRICE
                      Text(
                        'Rp ${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // STOCK
                      // Text(
                      //   'Stok: ${product.stock}',
                      //   style: const TextStyle(color: Colors.grey),
                      // ),
                      const SizedBox(height: 16),

                      // DESCRIPTION
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

      // ================= ADD TO CART =================
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                // TODO: add to cart
              },
              child: const Text(
                'Tambah ke Keranjang',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

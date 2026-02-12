import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/features/home/data/datasources/product_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/home/data/models/product_model.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/product_card.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/section_title.dart';

class FoodProductSection extends StatefulWidget {
  const FoodProductSection({super.key});

  @override
  State<FoodProductSection> createState() => _FoodProductSectionState();
}

class _FoodProductSectionState extends State<FoodProductSection> {
  final ProductRemoteDatasource _datasource = ProductRemoteDatasource();

  late Future<List<ProductModel>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _datasource.getFoodProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Produk Makanan'),
        const SizedBox(height: 12),

        SizedBox(
          height: 230,
          child: FutureBuilder<List<ProductModel>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Gagal memuat produk'));
              }

              final products = snapshot.data!;

              if (products.isEmpty) {
                return const Center(child: Text('Produk tidak tersedia'));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return InkWell(
                    onTap: () {
                      context.push('/product/${product.id}');
                    },
                    child: ProductCard(
                      title: product.name,
                      description: product.description,
                      price: 'Rp ${product.price}',
                      imageUrl: product.imageUrl,
                      onAddToCart: () {
                        // TODO: add to cart
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

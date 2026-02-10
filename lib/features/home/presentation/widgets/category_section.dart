import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/home/data/datasources/category_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/home/data/models/category_model.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/section_title.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final CategoryRemoteDatasource _datasource = CategoryRemoteDatasource();

  late Future<List<CategoryModel>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = _datasource.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Category'),
        const SizedBox(height: 10),

        SizedBox(
          height: 90,
          child: FutureBuilder<List<CategoryModel>>(
            future: _futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Gagal memuat kategori'));
              }

              final categories = snapshot.data!;

              if (categories.isEmpty) {
                return const Center(child: Text('Kategori kosong'));
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, index) {
                  final category = categories[index];

                  return Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.network(
                            category.iconUrl,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                            errorBuilder:
                                (_, __, ___) => const Icon(
                                  Icons.category,
                                  color: AppColors.primary,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(category.name, style: const TextStyle(fontSize: 12)),
                    ],
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

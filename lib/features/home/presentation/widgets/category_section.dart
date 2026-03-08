import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/section_title.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  final List<Map<String, String>> categories = const [
    {"name": "Makanan", "icon": "assets/svg/category_logo/Makanan.svg"},
    {"name": "Fashion", "icon": "assets/svg/category_logo/Fashion.svg"},
    {"name": "Elektronik", "icon": "assets/svg/category_logo/Elektronik.svg"},
    {"name": "Minuman", "icon": "assets/svg/category_logo/Minuman.svg"},
    {"name": "Herbal", "icon": "assets/svg/category_logo/Herbal.svg"},
    {"name": "Kecantikan", "icon": "assets/svg/category_logo/Kecantikan.svg"},
    {"name": "Olahraga", "icon": "assets/svg/category_logo/Olahraga.svg"},
    {"name": "Buku", "icon": "assets/svg/category_logo/Buku.svg"},
    {"name": "Hobi", "icon": "assets/svg/category_logo/Hobi.svg"},
    {"name": "Kesehatan", "icon": "assets/svg/category_logo/Kesehatan.svg"},
    {"name": "Alat Tulis", "icon": "assets/svg/category_logo/Alat Tulis.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Category'),
        const SizedBox(height: 10),

        SizedBox(
          height: 90,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final category = categories[index];

              return Column(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        category["icon"]!,
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
                  Text(category["name"]!, style: const TextStyle(fontSize: 12)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

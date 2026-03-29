import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class InfoMenuPage extends StatelessWidget {
  const InfoMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      {"title": "FAQ", "icon": Icons.help_outline, "route": "/faq"},
      {
        "title": "Cara Belanja",
        "icon": Icons.shopping_cart_outlined,
        "route": "/cara-belanja",
      },
      {
        "title": "Syarat & Ketentuan",
        "icon": Icons.description_outlined,
        "route": "/terms",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: menus.length,
        separatorBuilder:
            (_, __) => const Divider(
              height: 1,
              indent: 16, // jarak dari kiri
              endIndent: 16, // jarak dari kanan
            ),
        itemBuilder: (context, index) {
          final menu = menus[index];

          return ListTile(
            leading: Icon(menu["icon"] as IconData),
            title: Text(menu["title"] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context.push(menu["route"] as String);
            },
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(content, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

import 'package:flutter_warungnya_warga_net/config/env/prod_env.dart';

class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }

  /// 🔥 URL ICON SIAP PAKAI
  String get iconUrl => '${ProdEnv.storageUrl}/$icon';
}

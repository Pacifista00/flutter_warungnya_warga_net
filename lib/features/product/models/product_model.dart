import 'package:flutter_warungnya_warga_net/config/env/dev_env.dart';

class ProductModel {
  final String id;
  final String name;
  final String category;
  final String price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      category: json['category']['name'],
      price: json['price'].toString(),
      image: json['image'],
    );
  }

  /// 🔥 URL IMAGE FULL
  String get imageUrl => '${DevEnv.storageUrl}/$image';
}

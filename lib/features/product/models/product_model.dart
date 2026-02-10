import 'package:flutter_warungnya_warga_net/config/env/dev_env.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      price: json['price'].toString(),
      image: json['image'],
    );
  }

  /// 🔥 URL IMAGE FULL
  String get imageUrl => '${DevEnv.storageUrl}/$image';
}

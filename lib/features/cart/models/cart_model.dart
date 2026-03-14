import 'package:flutter_warungnya_warga_net/config/env/prod_env.dart';

class CartModel {
  final String id;
  final List<CartItem> items;

  CartModel({required this.id, required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      items: List<CartItem>.from(
        json['items'].map((x) => CartItem.fromJson(x)),
      ),
    );
  }
}

class CartItem {
  final String id;
  final String product;
  final int price;
  final int quantity;
  final String image;
  final int subtotal;

  CartItem({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
    required this.image,
    required this.subtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: json['product'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
      subtotal: json['subtotal'],
    );
  }

  String get imageUrl => "${ProdEnv.storageUrl}/$image";
}

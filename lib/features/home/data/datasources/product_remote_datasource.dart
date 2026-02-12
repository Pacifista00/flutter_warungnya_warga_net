import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/core/network/dio.dart';
import 'package:flutter_warungnya_warga_net/features/home/data/models/product_model.dart';

class ProductRemoteDatasource {
  final Dio dio = DioClient.create();

  /// BEST SELLER
  Future<List<ProductModel>> getBestSellerProducts() async {
    final response = await dio.get('/products/best-seller');
    final List data = response.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  /// LATEST PRODUCTS
  Future<List<ProductModel>> getLatestProducts() async {
    final response = await dio.get('/products/latest');
    final List data = response.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getFoodProducts() async {
    final response = await dio.get(
      '/home-products',
      queryParameters: {'category': 'makanan'},
    );
    final List data = response.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getElectronicProducts() async {
    final response = await dio.get(
      '/home-products',
      queryParameters: {'category': 'elektronik'},
    );
    final List data = response.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}

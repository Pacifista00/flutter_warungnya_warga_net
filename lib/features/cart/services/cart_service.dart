import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/cart_model.dart';
import 'package:flutter_warungnya_warga_net/features/cart/models/shipping_model.dart';
import '../../../core/network/dio_client.dart';

class CartService {
  final Dio _dio = DioClient.create();

  Future<void> addToCart({required String productId, int quantity = 1}) async {
    try {
      await _dio.post(
        "/cart/store",
        data: {"product_id": productId, "quantity": quantity},
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Failed add to cart");
    }
  }

  Future<CartModel> getCart() async {
    try {
      final response = await _dio.get("/cart");

      final data = response.data['data'];

      return CartModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Failed get cart");
    }
  }

  Future<void> updateCartItem({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      await _dio.put("/cart/update/$cartItemId", data: {"quantity": quantity});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Failed update cart");
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      await _dio.delete("/cart/delete/$cartItemId");
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Failed delete cart item");
    }
  }

  Future<List<ShippingModel>> getShippingPreview() async {
    final response = await _dio.get("/preview-shipping");

    final List data = response.data['shipping_options'];

    return data.map((e) => ShippingModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> checkout({
    required String courierCode,
    required String courierServiceCode,
    required int shippingPrice,
    String? voucherCode,
    int? pointsUsed,
  }) async {
    try {
      final response = await _dio.post(
        '/checkout',
        data: {
          'courier_code': courierCode,
          'courier_service_code': courierServiceCode,
          'shipping_price': shippingPrice,
          'voucher_code': voucherCode,
          'points_used': pointsUsed,
        },
      );

      return response.data; // bisa return response JSON
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? 'Checkout gagal');
      } else {
        throw Exception('Tidak dapat terhubung ke server');
      }
    }
  }

  Future<bool> checkUserHasAddress() async {
    final response = await _dio.get('/addresses');
    final List data = response.data;
    return data.isNotEmpty;
  }
}

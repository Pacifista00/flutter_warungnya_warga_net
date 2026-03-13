import 'package:dio/dio.dart';
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
}

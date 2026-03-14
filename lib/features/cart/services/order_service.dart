import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class OrderService {
  final Dio _dio = DioClient.create();

  Future<Map<String, dynamic>> getOrder(String id) async {
    final response = await _dio.get('/orders/$id');

    return response.data["data"];
  }
}

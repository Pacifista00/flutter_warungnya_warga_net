import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/features/order/models/order_model.dart';
import '../../../core/network/dio_client.dart';

class OrderService {
  final Dio _dio = DioClient.create();

  Future<OrderModel> getOrder(String orderId) async {
    final res = await _dio.get('/orders/$orderId');
    return OrderModel.fromJson(res.data['data']);
  }

  Future<List<OrderModel>> getMyOrders({String? status}) async {
    final res = await _dio.get(
      '/orders/me',
      queryParameters: status != null ? {'status': status} : null,
    );

    final List data = res.data['data']; // data adalah List
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }
}

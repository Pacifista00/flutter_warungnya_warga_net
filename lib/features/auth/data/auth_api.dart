import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class AuthApi {
  final Dio _dio = DioClient.create();

  Future<String> login(String email, String password) async {
    final response = await _dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    return response.data['token'];
  }
}

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

  Future<Map<String, dynamic>> me() async {
    final response = await _dio.get('/me');
    return response.data['user'];
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await _dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    await _dio.post('/verify-otp', data: {'email': email, 'otp': otp});
  }

  Future<void> resendOtp({required String email}) async {
    await _dio.post('/resend-otp', data: {'email': email});
  }
}

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

  Future<Map<String, dynamic>> updateUserProfile(
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.put(
      '/profile/update', // endpoint update profile di backend
      data: data,
    );

    // misal backend mengembalikan user terbaru
    return response.data['user'];
  }

  Future<Map<String, dynamic>> updatePhoto(String filePath) async {
    // 1. Siapkan file
    final file = await MultipartFile.fromFile(
      filePath,
      filename: filePath.split('/').last,
    );

    // 2. Gunakan POST, tapi tambahkan '_method': 'PUT'
    final formData = FormData.fromMap({
      'photo': file,
      '_method': 'PUT', // Ini kuncinya!
    });

    final response = await _dio.post(
      // Ubah dari .put ke .post
      '/profile/photo/update',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json', // Pastikan Laravel tahu ini request API
        },
      ),
    );

    return response.data['user'];
  }
}

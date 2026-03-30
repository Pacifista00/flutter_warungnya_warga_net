import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_exceptions.dart';

import '../../../core/storage/secure_storage.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api;

  AuthRepository(this.api);

  Future<void> login(String email, String password) async {
    try {
      final token = await api.login(email, password);
      await SecureStorage.saveToken(token);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        throw InvalidCredentialException();
      }

      if (statusCode == 403) {
        throw EmailNotVerifiedException(email);
      }

      throw AuthException('Terjadi kesalahan. Coba lagi.');
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    return await api.me();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await api.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<void> logout() async {
    await SecureStorage.clear();
  }

  Future<bool> isLoggedIn() async {
    return await SecureStorage.getToken() != null;
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      await api.verifyOtp(email: email, otp: otp);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'OTP tidak valid.';
      throw AuthException(message);
    }
  }

  Future<void> resendOtp({required String email}) async {
    try {
      await api.resendOtp(email: email);
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Gagal mengirim ulang kode.';
      throw AuthException(message);
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      final updatedUser = await api.updateUserProfile(data);
      return updatedUser;
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Gagal memperbarui profil';
      throw AuthException(message);
    }
  }

  Future<Map<String, dynamic>> updatePhoto(String filePath) async {
    try {
      final updatedUser = await api.updatePhoto(filePath);
      return updatedUser;
    } on DioException catch (e) {
      final message =
          e.response?.data['message'] ?? 'Gagal memperbarui foto profil';
      throw AuthException(message);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/features/auth/data/auth_api.dart';
import 'package:flutter_warungnya_warga_net/features/auth/data/auth_repository.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_exceptions.dart';
import 'domain/auth_state.dart';
import '../../core/storage/secure_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(AuthRepository(AuthApi())),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier(this.repository)
    : super(const AuthState(status: AuthStatus.unknown)) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      final token = await SecureStorage.getToken();

      if (token == null) {
        state = const AuthState(status: AuthStatus.unauthenticated);
        return;
      }

      /// CALL /me
      final user = await repository.getMe();

      final emailVerifiedAt = user['email_verified_at'];

      if (emailVerifiedAt == null) {
        state = AuthState(status: AuthStatus.emailNotVerified, user: user);
      } else {
        state = AuthState(status: AuthStatus.authenticated, user: user);
      }
    } catch (e) {
      await SecureStorage.clear();
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  /// DIPANGGIL SETELAH LOGIN
  Future<void> loginSuccess() async {
    try {
      final user = await repository.getMe();

      final emailVerifiedAt = user['email_verified_at'];
      print("EMAIL VERIFIED AT: ${user['email_verified_at']}");

      if (emailVerifiedAt == null) {
        state = AuthState(status: AuthStatus.emailNotVerified, user: user);
      } else {
        state = AuthState(status: AuthStatus.authenticated, user: user);
      }
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ?? 'Gagal mengambil data user.';

      throw AuthException(message);
    }
  }

  Future<void> logout() async {
    await SecureStorage.clear();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    if (state.user == null) return;

    try {
      final updatedUser = await repository.updateProfile(data);

      // update state user
      state = state.copyWith(user: {...?state.user, ...updatedUser});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePhoto(String filePath) async {
    if (state.user == null) return;

    try {
      final updatedUser = await repository.updatePhoto(filePath);

      // update state user
      state = state.copyWith(user: {...?state.user, ...updatedUser});
    } catch (e) {
      rethrow;
    }
  }

  bool get isLoggedIn => state.status == AuthStatus.authenticated;

  Map<String, dynamic>? get currentUser => state.user;
}

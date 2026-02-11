import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/features/auth/data/auth_api.dart';
import 'package:flutter_warungnya_warga_net/features/auth/data/auth_repository.dart';
import 'domain/auth_state.dart';
import '../../core/storage/secure_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>(
  (ref) => AuthNotifier(AuthRepository(AuthApi())),
);

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(AuthStatus.unknown) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      final token = await SecureStorage.getToken();

      if (token == null) {
        state = AuthStatus.unauthenticated;
        return;
      }

      /// CALL /me
      final user = await repository.getMe();

      final emailVerifiedAt = user['email_verified_at'];

      if (emailVerifiedAt == null) {
        state = AuthStatus.emailNotVerified;
      } else {
        state = AuthStatus.authenticated;
      }
    } catch (e) {
      /// token invalid / expired / 401
      await SecureStorage.clear();
      state = AuthStatus.unauthenticated;
    }
  }

  /// DIPANGGIL SETELAH LOGIN
  Future<void> loginSuccess({required bool emailVerified}) async {
    state =
        emailVerified ? AuthStatus.authenticated : AuthStatus.emailNotVerified;
  }

  Future<void> logout() async {
    await SecureStorage.clear();
    state = AuthStatus.unauthenticated;
  }

  bool get isLoggedIn => state == AuthStatus.authenticated;
}

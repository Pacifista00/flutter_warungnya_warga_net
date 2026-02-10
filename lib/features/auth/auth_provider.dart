import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'domain/auth_state.dart';
import '../../core/storage/secure_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthStatus> {
  AuthNotifier() : super(AuthStatus.unknown) {
    _checkAuth();
  }

  /// cek token saat app start
  Future<void> _checkAuth() async {
    final token = await SecureStorage.getToken();

    if (token == null) {
      state = AuthStatus.unauthenticated;
    } else {
      // TODO: nanti call API /me
      state = AuthStatus.emailNotVerified;
    }
  }

  /// DIPANGGIL SETELAH LOGIN BERHASIL
  Future<void> loginSuccess({required bool emailVerified}) async {
    state =
        emailVerified ? AuthStatus.authenticated : AuthStatus.emailNotVerified;
  }

  /// logout
  Future<void> logout() async {
    await SecureStorage.clear();
    state = AuthStatus.unauthenticated;
  }

  /// helper (opsional tapi berguna)
  bool get isLoggedIn => state == AuthStatus.authenticated;
}

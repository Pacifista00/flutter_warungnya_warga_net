import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/features/auth/data/auth_api.dart';
import 'package:flutter_warungnya_warga_net/features/auth/data/auth_repository.dart';
import 'auth_provider.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  final repository = AuthRepository(AuthApi());
  return AuthController(authNotifier, repository);
});

class AuthController {
  final AuthNotifier authNotifier;
  final AuthRepository repository;

  AuthController(this.authNotifier, this.repository);

  Future<void> login({required String email, required String password}) async {
    await repository.login(email, password);

    await authNotifier.loginSuccess();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<void> logout() async {
    await repository.logout();
    await authNotifier.logout();
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    await repository.verifyOtp(email: email, otp: otp);
  }

  Future<void> resendOtp({required String email}) async {
    await repository.resendOtp(email: email);
  }
}

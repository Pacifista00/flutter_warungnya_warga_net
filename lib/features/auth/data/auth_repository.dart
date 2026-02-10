import '../../../core/storage/secure_storage.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api;

  AuthRepository(this.api);

  Future<void> login(String email, String password) async {
    final token = await api.login(email, password);
    await SecureStorage.saveToken(token);
  }

  Future<void> logout() async {
    await SecureStorage.clear();
  }

  Future<bool> isLoggedIn() async {
    return await SecureStorage.getToken() != null;
  }
}

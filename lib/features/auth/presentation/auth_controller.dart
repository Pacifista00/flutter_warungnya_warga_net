import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

class AuthController extends StateNotifier<bool> {
  final AuthRepository repo;

  AuthController(this.repo) : super(false) {
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    state = await repo.isLoggedIn();
  }

  Future<void> login(String email, String password) async {
    await repo.login(email, password);
    state = true;
  }

  Future<void> logout() async {
    await repo.logout();
    state = false;
  }
}

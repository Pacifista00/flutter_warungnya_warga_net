enum AuthStatus { unknown, authenticated, unauthenticated, emailNotVerified }

class AuthState {
  final AuthStatus status;
  final Map<String, dynamic>? user;

  const AuthState({required this.status, this.user});

  AuthState copyWith({AuthStatus? status, Map<String, dynamic>? user}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }
}

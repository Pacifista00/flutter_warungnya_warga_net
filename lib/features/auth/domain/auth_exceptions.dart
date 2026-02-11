class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class InvalidCredentialException extends AuthException {
  InvalidCredentialException() : super('Email atau password salah.');
}

class EmailNotVerifiedException extends AuthException {
  final String email;
  EmailNotVerifiedException(this.email) : super('Email belum diverifikasi.');
}

class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});

  @override
  String toString() {
    switch (message) {
      case 'invalid-credential':
        const AuthException(message: 'wrong email or password');
      case 'user-doesn\'t-exist':
        const AuthException(message: 'email is not registered yet');
      case 'email-already-used':
        const AuthException(message: 'email-already-used');
      case 'username-already-used':
        const AuthException(message: 'username already used');
      default:
        AuthException(message: message);
    }
    return super.toString();
  }
}

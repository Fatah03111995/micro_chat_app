class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});

  @override
  String toString() {
    switch (message) {
      case 'invalid-credential':
        return 'wrong email or password';

      case 'user-doesn\'t-exist':
        return 'email is not registered yet';

      case 'email-already-used':
        return 'email already used';

      case 'username-already-used':
        return 'username already used';

      default:
        return message;
    }
  }
}

abstract class LoginEvent {
  const LoginEvent();
}

class LoginEmailEvent extends LoginEvent {
  final String newValueEmail;

  const LoginEmailEvent({required this.newValueEmail});
}

class LoginPasswordEvent extends LoginEvent {
  final String newValuePassword;

  const LoginPasswordEvent({required this.newValuePassword});
}

class LoginIsNotVisibleEvent extends LoginEvent {}

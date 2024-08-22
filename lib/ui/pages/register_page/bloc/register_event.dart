import 'dart:io';

class RegisterEvent {
  const RegisterEvent();
}

class RegisterFirstNameEvent extends RegisterEvent {
  final String newValue;

  const RegisterFirstNameEvent({required this.newValue});
}

class RegisterLastNameEvent extends RegisterEvent {
  final String newValue;

  const RegisterLastNameEvent({required this.newValue});
}

class RegisterUserNameEvent extends RegisterEvent {
  final String newValue;

  const RegisterUserNameEvent({required this.newValue});
}

class RegisterEmailEvent extends RegisterEvent {
  final String newValue;

  const RegisterEmailEvent({required this.newValue});
}

class RegisterPasswordEvent extends RegisterEvent {
  final String newValue;

  const RegisterPasswordEvent({required this.newValue});
}

class RegisterConfirmPasswordEvent extends RegisterEvent {
  final String newValue;

  const RegisterConfirmPasswordEvent({required this.newValue});
}

class RegisterPhotoProfileEvent extends RegisterEvent {
  late File? newValue;

  RegisterPhotoProfileEvent({this.newValue});
}

class RegisterToggleVisiblePasswordEvent extends RegisterEvent {}

class RegisterToggleVisibleConfirmPasswordEvent extends RegisterEvent {}

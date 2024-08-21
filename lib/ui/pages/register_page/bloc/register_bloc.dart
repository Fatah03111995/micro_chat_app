import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:micro_chat_app/core/exception/auth_exception.dart';
import 'package:micro_chat_app/core/util/util_component.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_event.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterFirstNameEvent>(_onFirstNameEventHandler);
    on<RegisterLastNameEvent>(_onLastNameEventHandler);
    on<RegisterUserNameEvent>(_onUserNameEventHandler);
    on<RegisterEmailEvent>(_onEmailEventHandler);
    on<RegisterPasswordEvent>(_onPasswordEventHandler);
    on<RegisterConfirmPasswordEvent>(_onConfirmPasswordEventHandler);
    on<RegisterPhotoProfileEvent>(_onPhotoProfileEventHandler);
    on<RegisterToggleVisiblePasswordEvent>(
        _onRegisterToggleVisiblePasswordHandler);
    on<RegisterToggleVisibleConfirmPasswordEvent>(
        _onRegisterToggleVisibleConfirmPasswordHandler);
    on<RegisterSendEvent>(_onRegisterSendHandler);
  }

  _onFirstNameEventHandler(RegisterFirstNameEvent event, Emitter emit) {
    emit(state.copyWith(firstName: event.newValue));
  }

  _onLastNameEventHandler(RegisterLastNameEvent event, Emitter emit) {
    emit(state.copyWith(lastName: event.newValue));
  }

  _onUserNameEventHandler(RegisterUserNameEvent event, Emitter emit) {
    emit(state.copyWith(username: event.newValue));
  }

  _onEmailEventHandler(RegisterEmailEvent event, Emitter emit) {
    emit(state.copyWith(email: event.newValue));
  }

  _onPasswordEventHandler(RegisterPasswordEvent event, Emitter emit) {
    emit(state.copyWith(password: event.newValue));
  }

  _onConfirmPasswordEventHandler(
      RegisterConfirmPasswordEvent event, Emitter emit) {
    emit(state.copyWith(confirmPassword: event.newValue));
  }

  _onPhotoProfileEventHandler(
      RegisterPhotoProfileEvent event, Emitter emit) async {
    try {
      if (event.newValue == null) {
        final pickedImage = await ImagePicker()
            .pickImage(source: ImageSource.gallery, maxWidth: 600);
        if (pickedImage != null) {
          emit(state.copyWith(photoProfilePath: File(pickedImage.path)));
          return;
        }
      } else {
        emit(state.copyWith(photoProfilePath: event.newValue));
      }
    } catch (e) {
      print(e);
    }
  }

  _onRegisterToggleVisiblePasswordHandler(
      RegisterToggleVisiblePasswordEvent event, Emitter emit) {
    emit(state.copyWith(isPassNotVisible: !state.isPassNotVisible));
  }

  _onRegisterToggleVisibleConfirmPasswordHandler(
      RegisterToggleVisibleConfirmPasswordEvent event, Emitter emit) {
    emit(state.copyWith(
        isConfirmPassNotVisible: !state.isConfirmPassNotVisible));
  }

  _onRegisterSendHandler(RegisterSendEvent event, Emitter emit) async {
    final authRepositories = event.authRepositories;
    try {
      await authRepositories.register();
    } on AuthException catch (e) {
      UtilComponent.toastErr(e.message);
    }
  }
}

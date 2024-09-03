import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_event.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_state.dart';
import 'package:micro_chat_app/core/exception/auth_exception.dart';
import 'package:micro_chat_app/core/util/util_component.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    on<AuthEventLogIn>(_onAuthEventLogInHandler);
    on<AuthEventRegister>(_onAuthEventRegisterHandler);
    on<AuthEventLogOut>(_onAuthEventLogOutHandler);
  }

  void _onAuthEventLogInHandler(AuthEventLogIn event, Emitter emit) async {
    emit(AuthStateLoading());
    final authRepositories = event.authRepositories;

    try {
      if (event.email.isEmpty || event.password.isEmpty) {
        throw const AuthException(message: 'fill all column');
      }
      final response =
          await authRepositories.logIn(event.email, event.password);

      UtilComponent.toastSuccess(
          'Welcome ${response.firstName} ${response.lastName} !');
      emit(AuthStateSuccess(user: response));
    } on AuthException catch (e) {
      UtilComponent.toastErr(e.toString());
      emit(AuthStateFailed());
    } catch (e) {
      UtilComponent.toastErr(e.toString());
      emit(AuthStateFailed());
    }
  }

  void _onAuthEventRegisterHandler(
      AuthEventRegister event, Emitter emit) async {
    emit(AuthStateLoading());
    try {
      if (event.firstName.isEmpty ||
          event.lastName.isEmpty ||
          event.userName.isEmpty ||
          event.email.isEmpty ||
          event.password.isEmpty ||
          event.confirmPassword.isEmpty ||
          event.lastName.isEmpty) {
        throw const AuthException(message: 'please fill all column');
      }

      if (event.photoProfilePath == null) {
        throw const AuthException(message: 'please take a picture');
      }

      final authRepositories = event.authRepositories;
      await authRepositories.register(
        firstName: event.firstName,
        lastName: event.lastName,
        userName: event.userName,
        email: event.email,
        password: event.password,
        fcmToken: '',
        photoProfilePath: event.photoProfilePath!,
      );
      UtilComponent.toastSuccess('Registration Success, Please Login');
      emit(AuthStateRegisterSuccess());
    } on AuthException catch (e) {
      UtilComponent.toastErr(e.toString());
      emit(AuthStateFailed());
    } catch (e) {
      UtilComponent.toastErr(e.toString());
      emit(AuthStateFailed());
    }
  }

  void _onAuthEventLogOutHandler(AuthEventLogOut event, Emitter emit) {
    emit(AuthStateLoading());
    emit(AuthStateInitial());
  }
}

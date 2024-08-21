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
      emit(AuthStateSuccess(user: response));
    } on AuthException catch (e) {
      UtilComponent.toastErr(e.toString());
    } catch (e) {
      UtilComponent.toastErr(e.toString());
      emit(AuthStateFailed());
    }
  }

  void _onAuthEventRegisterHandler(
      AuthEventRegister event, Emitter emit) async {
    emit(AuthStateLoading());
    try {} catch (e) {
      emit(AuthStateFailed());
    }
  }

  void _onAuthEventLogOutHandler(AuthEventLogOut event, Emitter emit) {
    emit(AuthStateLoading());
    emit(AuthStateInitial());
  }
}

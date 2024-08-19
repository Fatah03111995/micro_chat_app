import 'package:bloc/bloc.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_event.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailEvent>(_onEmailEventHandler);
    on<LoginPasswordEvent>(_onPasswordEventHandler);
    on<LoginIsNotVisibleEvent>(_onLoginIsNotVisibleHandler);
  }

  _onEmailEventHandler(LoginEmailEvent event, Emitter emit) {
    emit(state.copyWith(email: event.newValueEmail));
  }

  _onPasswordEventHandler(LoginPasswordEvent event, Emitter emit) {
    emit(state.copyWith(password: event.newValuePassword));
  }

  _onLoginIsNotVisibleHandler(LoginIsNotVisibleEvent event, Emitter emit) {
    emit(state.copyWith(isPassNotVisible: !state.isPassNotVisible));
  }
}

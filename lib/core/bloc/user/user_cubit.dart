import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/user/user_state.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  changeData(UserModel? user) {
    emit(UserState(user: user));
  }
}

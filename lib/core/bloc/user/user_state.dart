import 'package:equatable/equatable.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

class UserState extends Equatable {
  final UserModel? user;
  const UserState({this.user});

  @override
  List<Object?> get props => [user];
}

import 'package:micro_chat_app/core/data_provider/auth_data_provider.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

abstract class AuthRepositories {
  Future<UserModel> logIn(String email, String password);
  Future<UserModel> register();
  void logOut();
}

class ExpressAuth implements AuthRepositories {
  @override
  Future<UserModel> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<UserModel> logIn(String email, String password) async {
    try {
      UserModel result =
          await AuthDataProvider.login(email: email, password: password);
      return result;
    } catch (e) {
      print(e);
    }
    throw 'repository-error-login';
  }

  @override
  void logOut() {
    // TODO: implement signOut
  }
}

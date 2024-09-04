import 'package:micro_chat_app/core/models/user_model.dart';

class Dummydata {
  static List<UserModel> get friends => [
        const UserModel(
          userId: 'userId',
          firstName: 'ahmad',
          lastName: 'fatihin',
          userName: 'cool_person',
          email: '',
          userToken: '',
          fcmToken: '',
          photoProfilePath: '',
        )
      ];
}

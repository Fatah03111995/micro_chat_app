import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_event.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/core/router/page_path.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_bloc.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_state.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/widget/dashboard_bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthStateSuccess) {
      //---------GET ONLINE USER
      authState.socket.on('getOnlineUsers', (data) {
        final List<dynamic> fromServer = data;
        if (fromServer.isNotEmpty) {
          final List<String> onlineUsers =
              fromServer.map((el) => el.toString()).toList();
          UserModel user = context.read<UserCubit>().state.user!;
          context
              .read<UserCubit>()
              .changeData(user.copyWith(onlineUsers: onlineUsers));
        }
      });
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.runtimeType != AuthStateSuccess) {
          Navigator.pushReplacementNamed(context, PagePath.login);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Micro Chat',
              style: TextStyles.mlBold.copyWith(color: MyColors.blue1),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    AuthState authState = context.read<AuthBloc>().state;
                    if (authState is AuthStateSuccess) {
                      authState.socket.disconnect();
                    }
                    context.read<AuthBloc>().add(AuthEventLogOut());
                    context.read<UserCubit>().changeData(null);
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: BlocSelector<DashboardBloc, DashboardState, int>(
                selector: (state) {
                  return state.indexPage;
                },
                builder: (context, indexPage) {
                  return AppRoutes.getDashboardPage(indexPage).page;
                },
              ),
            ),
          ),
          bottomNavigationBar: const DashboardBottomNavigator()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Micro Chat',
            style: TextStyles.mlBold.copyWith(color: MyColors.blue1),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventLogOut());
                  context.read<UserCubit>().changeData(null);
                  context.read<ChatBloc>().add(Disconnect());
                  Navigator.pushNamedAndRemoveUntil(
                      context, PagePath.login, (route) => false);
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
        bottomNavigationBar: const DashboardBottomNavigator());
  }
}

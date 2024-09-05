import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/core/router/page_path.dart';
import 'package:micro_chat_app/core/services/io_socket_services.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_bloc.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_state.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/widget/dashboard_bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    IOSocketServices().startConnect();
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBgColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Micro Chat',
            style: TextStyles.mlBold.copyWith(color: MyColors.blue1),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, PagePath.login,
                      (route) {
                    return false;
                  });
                  context.read<AuthBloc>().add(AuthEventLogOut());
                  context.read<ChatBloc>().add(Disconnect());
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

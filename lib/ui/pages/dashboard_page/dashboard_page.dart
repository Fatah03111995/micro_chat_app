import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_event.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_state.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/core/router/page_path.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_bloc.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_state.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/widget/dashboard_bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.runtimeType != AuthStateSuccess) {
          Navigator.pushReplacementNamed(context, PagePath.login);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogOut());
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: Center(
            child: BlocSelector<DashboardBloc, DashboardState, int>(
              selector: (state) {
                return state.indexPage;
              },
              builder: (context, indexPage) {
                return AppRoutes.getDashboardPage(indexPage).page;
              },
            ),
          ),
          bottomNavigationBar: const DashboardBottomNavigator()),
    );
  }
}

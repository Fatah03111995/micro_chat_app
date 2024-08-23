import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/router/page_entity.dart';
import 'package:micro_chat_app/core/router/page_path.dart';
import 'package:micro_chat_app/ui/pages/chat_page/chat_page.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/dashboard_page.dart';
import 'package:micro_chat_app/ui/pages/friends_page/friends_page.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_bloc.dart';
import 'package:micro_chat_app/ui/pages/login_page/login_page.dart';
import 'package:micro_chat_app/ui/pages/profile_page/profile_page.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_bloc.dart';
import 'package:micro_chat_app/ui/pages/register_page/register_page.dart';

class AppRoutes {
  static List<PageEntity> get pageEntities => [
        PageEntity(
          path: PagePath.login,
          page: BlocProvider(
            create: (_) => LoginBloc(),
            child: const LoginPage(),
          ),
        ),
        PageEntity(
          path: PagePath.register,
          page: BlocProvider(
            create: (_) => RegisterBloc(),
            child: const RegisterPage(),
          ),
        ),
        PageEntity(
          path: PagePath.login,
          page: const DashboardPage(),
        ),
      ];

  static List<PageEntity> get dashboardPageEntities => [
        PageEntity(
          title: 'Chat',
          icon: Icons.chat,
          path: PagePath.chat,
          page: const ChatPage(),
        ),
        PageEntity(
            title: 'Friends',
            icon: Icons.groups_2,
            path: PagePath.friends,
            page: const FriendsPage()),
        PageEntity(
            title: 'Profile',
            icon: Icons.person,
            path: PagePath.profile,
            page: const ProfilePage()),
      ];

  static List<PageEntity> getPageEntity(String path) {
    return pageEntities.where((el) => el.path == path).toList();
  }

  static PageEntity getDashboardPage(int index) {
    return dashboardPageEntities[index];
  }

  static Route onGenerateRoute(RouteSettings setting) {
    List<PageEntity> page = getPageEntity(setting.name ?? '');
    List<PageEntity> defaultPage = getPageEntity(PagePath.login);

    if (page.isNotEmpty) {
      return MaterialPageRoute(builder: (context) => page.first.page);
    }

    return MaterialPageRoute(builder: (context) => defaultPage.first.page);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/cubit/dashboard_cubit.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/cubit/dashboard_state.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/widget/dashboard_bottom_navigation.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: BlocSelector<DashboardCubit, DashboardState, int>(
            selector: (state) {
              return state.indexPage;
            },
            builder: (context, indexPage) {
              return AppRoutes.getDashboardPage(indexPage).page;
            },
          ),
        ),
        bottomNavigationBar: const DashboardBottomNavigator());
  }

  @override
  void dispose() {
    context.read<DashboardCubit>().close();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/theme/theme_cubit.dart';
import 'package:micro_chat_app/core/bloc/theme/theme_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/core/router/page_path.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AppObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
      BlocProvider(
        create: (context) => DashboardBloc(),
      ),
      BlocProvider(
        create: (context) => UserCubit(),
      ),
      BlocProvider(
        create: (context) => ChatBloc(),
        lazy: false,
      ),
      BlocProvider(
        create: (context) => ThemeCubit(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.darkTheme ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            initialRoute: PagePath.login,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}

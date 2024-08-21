import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/app_observer.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_bloc.dart';
import 'package:micro_chat_app/ui/pages/login_page/login_page.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_bloc.dart';
import 'package:micro_chat_app/ui/pages/register_page/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  Bloc.observer = AppObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          )
        ],
        child: MaterialApp(
          home: Scaffold(
              body: BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginPage(),
          )),
        ),
      ),
    );
  }
}

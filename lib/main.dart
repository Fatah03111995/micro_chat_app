import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/app_observer.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/core/router/page_path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  Bloc.observer = AppObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: PagePath.login,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}

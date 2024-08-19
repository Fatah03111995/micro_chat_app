import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/ui/pages/login_page/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      child: MaterialApp(
        home: Scaffold(body: LoginPage()),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mini_taskhub/app/theme.dart';
import 'package:mini_taskhub/presentation/auth/login_screen.dart';
import 'package:mini_taskhub/routes/app_routes.dart';
import 'package:mini_taskhub/services/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini TaskHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: getIt<AppRouter>().navigatorKey,
      home: const LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_taskhub/app/app_theme.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/logic/auth/auth_state_cubit.dart';
import 'package:mini_taskhub/presentation/auth/login_screen.dart';
import 'package:mini_taskhub/presentation/dashboard/dashboard_screen.dart';
import 'package:mini_taskhub/provider/theme_provider.dart';
import 'package:mini_taskhub/routes/app_routes.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:provider/provider.dart';

void main() async {
  await setupServiceLocator();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Mini TaskHub',
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).getTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
        navigatorKey: getIt<AppRouter>().navigatorKey,
        home: BlocBuilder<AuthCubit, AuthStateCubit>(
          bloc: getIt<AuthCubit>(),
          builder: (context, state) {
            if (state.status == AuthStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == AuthStatus.authenticated) {
              return const DashboardScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

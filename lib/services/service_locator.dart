import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_taskhub/key.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/routes/app_routes.dart';
import 'package:mini_taskhub/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  // for transparent status bar
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent, // Optional: transparent status bar
  //     statusBarIconBrightness: Brightness.light, // White icons for Android
  //     statusBarBrightness: Brightness.dark, // White icons for iOS
  //   ),
  // );

  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      supabaseService: SupabaseService(),
    ),
  );
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());
}

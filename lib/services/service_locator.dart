import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_taskhub/key.dart';
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

  getIt.registerSingleton<SupabaseService>(SupabaseService());

  getIt.registerSingleton<AppRouter>(AppRouter());
}

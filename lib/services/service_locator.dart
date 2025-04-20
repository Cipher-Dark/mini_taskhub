import 'package:get_it/get_it.dart';
import 'package:mini_taskhub/routes/app_routes.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}

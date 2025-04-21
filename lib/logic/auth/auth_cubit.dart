import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_taskhub/logic/auth/auth_state_cubit.dart';
import 'package:mini_taskhub/presentation/auth/login_screen.dart';
import 'package:mini_taskhub/routes/app_routes.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:mini_taskhub/services/supabase_service.dart';

class AuthCubit extends Cubit<AuthStateCubit> {
  final SupabaseService _supabaseService;
  StreamSubscription? _userSubscription;

  AuthCubit({required SupabaseService supabaseService})
      : _supabaseService = supabaseService,
        super(const AuthStateCubit()) {
    init();
  }

  void init() {
    emit(state.copyWith(status: AuthStatus.initial));
    _userSubscription?.cancel();
    _userSubscription = _supabaseService.userStream.listen((user) {
      if (user.session?.user.id != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            userId: user.session?.user.id,
          ),
        );
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final response = await _supabaseService.signUp(email, password);
      if (response.session?.user.id != null) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            userId: response.session?.user.id,
          ),
        );
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error, error: e.toString()),
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final response = await _supabaseService.signInWithEmail(email, password);
      if (response.session?.user.id != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          userId: response.session?.user.id,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error, error: e.toString()),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseService.signOut();
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}

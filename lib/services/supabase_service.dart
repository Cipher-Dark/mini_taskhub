import 'package:mini_taskhub/services/base_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends BaseService {
  Stream get userStream => supabase.auth.onAuthStateChange;

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      final data = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return data;
    } catch (e) {
      if (e is AuthException &&
          e.message.contains(
            "Invalid login credentials",
          )) {
        throw "Invalid email or password";
      } else if (e is AuthException &&
          e.message.contains(
            "ClientException with SocketException",
          )) {
        throw "No internet connection";
      } else {
        throw ("Sign-in failed");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw "Cant sign out";
    }
  }

  Future<AuthResponse> signUp(String email, String password) async {
    try {
      final data = await supabase.auth.signUp(email: email, password: password);
      return data;
    } catch (e) {
      if (e is AuthException && e.message.contains("User already registered")) {
        throw "Email is already registered. Please sign in.";
      } else if (e is AuthException &&
          e.message.contains(
            "ClientException with SocketException",
          )) {
        throw "No internet connection";
      } else {
        throw "Can't signUp try again";
      }
    }
  }
}

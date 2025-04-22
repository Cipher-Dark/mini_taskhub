import 'dart:developer';

import 'package:mini_taskhub/presentation/dashboard/task_model.dart';
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

  Future<void> addTask({
    required String title,
    required String data,
    required String userId,
  }) async {
    try {
      await supabase.from('tasks').insert({
        'user_id': userId,
        'title': title,
        'data': data,
      });
    } catch (e) {
      throw "Can't add task";
    }
  }

  Stream<List<TaskModel>> getTasks(String userId) {
    return supabase
        .from('tasks')
        .stream(primaryKey: [
          'id'
        ])
        .eq('user_id', userId)
        .map((maps) => maps.map((map) => TaskModel.fromJson(map)).toList());
  }

  Future<void> updateTask(TaskModel task) async {
    log(task.id.toString());
    log(task.title);
    log(task.data);

    try {
      await database.update({
        'title': task.title,
        'data': task.data,
      }).eq('id', task.id);
    } catch (e) {
      throw "Can't update task";
    }
  }

  Future<void> deleteTask(int taskId) async {
    log(taskId.toString());
    try {
      await database.delete().eq('id', taskId);
    } catch (e) {
      throw "Can't delete task";
    }
  }

  Future<void> setComplete(int taskId) async {
    try {
      await database.update({
        'is_completed': true,
      }).eq('id', taskId);
    } catch (e) {
      throw "Can't set task as completed";
    }
  }
}

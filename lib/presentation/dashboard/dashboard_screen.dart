import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/presentation/dashboard/task_model.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:mini_taskhub/services/supabase_service.dart';
import 'package:mini_taskhub/widgets/custom_button.dart';
import 'package:mini_taskhub/widgets/custom_text_filed.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: .8),
          title: Text('Logout'),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await getIt<AuthCubit>().signOut();
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  void showAddTaskDialog(String uid) {
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: .8),
        title: Text(
          'Add Task',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              CustomTextFiled(
                controller: _titleController,
                hintText: 'Title',
                obscureText: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              CustomTextFiled(
                controller: _dataController,
                hintText: 'Description',
                obscureText: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          CustomButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                await getIt<SupabaseService>().addTask(
                  title: _titleController.text,
                  data: _dataController.text,
                  userId: uid,
                );
                _titleController.clear();
                _dataController.clear();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void showDeleteDialof(int uid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: .8),
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await getIt<SupabaseService>().deleteTask(uid);
              setState(() {});
            },
            child: Text("Delete"),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _dataController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = getIt<AuthCubit>().state.userId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Task Hub"),
        actions: [
          IconButton(
            onPressed: showLogoutDialog,
            splashColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(uid!),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: getIt<SupabaseService>().getTasks(uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No tasks found"));
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.data),
                trailing: IconButton(
                  onPressed: () => showDeleteDialof(task.id),
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

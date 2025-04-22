import 'package:flutter/material.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/presentation/dashboard/task_model.dart';
import 'package:mini_taskhub/provider/theme_provider.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:mini_taskhub/services/supabase_service.dart';
import 'package:mini_taskhub/widgets/custom_button.dart';
import 'package:mini_taskhub/widgets/custom_text_filed.dart';
import 'package:provider/provider.dart';

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

  void showEditTaskDialog(TaskModel task) {
    final formKey = GlobalKey<FormState>();
    _titleController.text = task.title;
    _dataController.text = task.data;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: .8),
        title: Text('Edit Task'),
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
                task.title = _titleController.text;
                task.data = _dataController.text;
                await getIt<SupabaseService>().updateTask(task);
              }
            },
            text: 'Edit',
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
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  100,
                  100,
                  10,
                  0,
                ),
                items: [
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Dark Mode"),
                        Switch(
                          value: context.read<ThemeProvider>().getTheme,
                          onChanged: (value) {
                            context.read<ThemeProvider>().toggleTheme(value);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () => showLogoutDialog(),
                    child: Text("Logout"),
                  ),
                ],
              );
            },
            icon: Icon(Icons.menu),
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
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Dismissible(
                  key: Key(task.id.toString()),
                  direction: DismissDirection.horizontal,
                  // onDismissed: (direction) => showDeleteDialof(task.id),
                  confirmDismiss: (direction) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Task"),
                          content: const Text("Are you sure you want to delete this task?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop(true);
                                await getIt<SupabaseService>().deleteTask(task.id);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    onLongPress: () => showEditTaskDialog(task),
                    title: Text(task.title),
                    subtitle: Text(task.data),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

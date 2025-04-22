import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_taskhub/presentation/dashboard/task_model.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:mini_taskhub/services/supabase_service.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function() onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        decoration: task.isComplete ? TextDecoration.lineThrough : null,
                      ),
                ),
                Row(
                  spacing: 20,
                  children: [
                    InkWell(onTap: () => onEdit(), child: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary)),
                    GestureDetector(
                      onTap: () {
                        getIt<SupabaseService>().setComplete(
                          task.id,
                          !task.isComplete,
                        );
                      },
                      child: Icon(
                        task.isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: task.isComplete ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              task.data,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: task.isComplete ? TextDecoration.lineThrough : null,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('dd MMM yyyy').format(task.createdAt)),
                !task.isComplete
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Not Completed",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Completed",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

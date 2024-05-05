import 'package:flutter/material.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class TasksList extends StatelessWidget {
  final List<TaskData> tasks;
  const TasksList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
              );
            },
          ),
        ),
      ],
    );
  }
}

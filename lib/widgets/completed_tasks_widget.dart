import 'package:flutter/material.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class CompletedTasksListWidget extends StatefulWidget {
  final List<TaskData> completedTasks;
  const CompletedTasksListWidget({
    super.key,
    required this.completedTasks,
  });

  @override
  State<CompletedTasksListWidget> createState() =>
      _CompletedTasksListWidgetState();
}

class _CompletedTasksListWidgetState extends State<CompletedTasksListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.completedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.completedTasks[index];
              return ListTile(
                title: Text(task.title),
              );
            },
          ),
        ),
      ],
    );
  }
}

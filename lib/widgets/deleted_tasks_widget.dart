import 'package:flutter/material.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class DeletedTasksListWidget extends StatefulWidget {
  final List<TaskData> deletedTasks;
  const DeletedTasksListWidget({
    super.key,
    required this.deletedTasks,
  });

  @override
  State<DeletedTasksListWidget> createState() =>
      _DeletedTasksListWidgetState();
}

class _DeletedTasksListWidgetState extends State<DeletedTasksListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.deletedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.deletedTasks[index];
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/models/task_model.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          Task task = tasks[index];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) =>
                  context.read<TaskBloc>().add(UpdateTaskEvent(task: task)),
            ),
            onLongPress: () =>
                context.read<TaskBloc>().add(DeleteTaskEvent(task: task)),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class QueryTasksWidget extends StatefulWidget {
  final List<TaskData> queryTasks;
  const QueryTasksWidget({super.key, required this.queryTasks});

  @override
  State<QueryTasksWidget> createState() => _QueryTasksWidgetState();
}

class _QueryTasksWidgetState extends State<QueryTasksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.queryTasks.length,
      itemBuilder: (context, index) {
        TaskData task = widget.queryTasks[index];
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(task.title),
                  Text('From: ${task.categoryName}')
                ],
              ),
              Text(task.description)
            ],
          ),
        );
      },
    );
  }
}

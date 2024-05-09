import 'package:flutter/material.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class FavoriteTasksListWidget extends StatefulWidget {
  final List<TaskData> favoriteTasks;
  const FavoriteTasksListWidget({
    super.key,
    required this.favoriteTasks,
  });

  @override
  State<FavoriteTasksListWidget> createState() =>
      _FavoriteTasksListWidgetState();
}

class _FavoriteTasksListWidgetState extends State<FavoriteTasksListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.favoriteTasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.favoriteTasks[index];
              return ListTile(
                title: Text(task.title),
                leading: task.isFavorite
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/change_task_screen.dart';

enum TaskActions {
  edit,
  removeFromBookmarks,
  delete,
}

class FavoritedTasksListWidget extends StatefulWidget {
  final List<TaskData> favoritedTasks;
  const FavoritedTasksListWidget({
    super.key,
    required this.favoritedTasks,
  });

  @override
  State<FavoritedTasksListWidget> createState() =>
      _FavoritedTasksListWidgetState();
}

class _FavoritedTasksListWidgetState extends State<FavoritedTasksListWidget> {
  void _changeTaskInCategory({required TaskData task}) {
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return SingleChildScrollView(
          child: ChangeTaskScreen(
            task: task,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.favoritedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.favoritedTasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text('Task completed from: ${task.categoryName}'),
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Название задачи: ${task.title}"),
                      content: Text("Описание задачи: ${task.description}"),
                    );
                  },
                ),
                leading: task.isFavorite
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_outline),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: task.isDone,
                      onChanged: (bool? newValue) => {
                        if (newValue != null)
                          {
                            context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                    categoryId: task.categoryId,
                                    taskId: task.id,
                                    isDone: newValue,
                                  ),
                                )
                          },
                      },
                    ),
                    PopupMenuButton<TaskActions>(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: TaskActions.edit,
                            onTap: () => _changeTaskInCategory(task: task),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit_outlined),
                                SizedBox(width: 5),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: TaskActions.removeFromBookmarks,
                            onTap: () => context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                      taskId: task.id,
                                      categoryId: task.categoryId,
                                      isFavorite: !task.isFavorite),
                                ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.bookmark_add_outlined),
                                SizedBox(width: 5),
                                Text('Remove from bookmarks'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: TaskActions.delete,
                            onTap: () => context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                      taskId: task.id,
                                      categoryId: task.categoryId,
                                      isDeleted: !task.isDeleted),
                                ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete_outline),
                                SizedBox(width: 5),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ];
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

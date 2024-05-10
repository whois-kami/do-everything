import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/change_task_screen.dart';

enum TaskActions {
  edit,
  addToBookmarks,
  restore,
}

class DeletedTasksListWidget extends StatefulWidget {
  final List<TaskData> deletedTasks;
  const DeletedTasksListWidget({
    super.key,
    required this.deletedTasks,
  });

  @override
  State<DeletedTasksListWidget> createState() => _DeletedTasksListWidgetState();
}

class _DeletedTasksListWidgetState extends State<DeletedTasksListWidget> {
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
            itemCount: widget.deletedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.deletedTasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text('Deleted from: ${task.categoryName}'),
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
                                Icon(Icons.edit),
                                SizedBox(width: 5),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: TaskActions.addToBookmarks,
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
                                Text('Add to bookmarks'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: TaskActions.restore,
                            onTap: () => context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                      taskId: task.id,
                                      categoryId: task.categoryId,
                                      isDeleted: !task.isDeleted),
                                ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 5),
                                Text('Restore'),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

enum TaskActions {
  edit,
  addToBookmarks,
  delete,
}

class TasksInCategoriesWidget extends StatefulWidget {
  final List<TaskData> tasks;
  const TasksInCategoriesWidget({
    super.key,
    required this.tasks,
  });

  @override
  State<TasksInCategoriesWidget> createState() =>
      _TasksInCategoriesWidgetState();
}

class _TasksInCategoriesWidgetState extends State<TasksInCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.tasks[index];
              String formattedDate = DateFormat('d MMMM, EEEE HH:mm', 'ru_RU')
                  .format(task.createdAt);
              return ListTile(
                title: Text(task.title),
                subtitle: Text(formattedDate),
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
                            onTap: () {},
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
                                Icon(Icons.delete),
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

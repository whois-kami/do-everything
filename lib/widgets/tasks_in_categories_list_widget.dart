import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/change_task_screen.dart';

enum TaskActions {
  edit,
  addToBookmarks,
  delete,
}

class TasksInCategoriesListWidget extends StatefulWidget {
  final List<TaskData> tasks;
  const TasksInCategoriesListWidget({
    super.key,
    required this.tasks,
  });

  @override
  State<TasksInCategoriesListWidget> createState() =>
      _TasksInCategoriesListWidgetState();
}

class _TasksInCategoriesListWidgetState
    extends State<TasksInCategoriesListWidget> {
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
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width % 20,
                vertical: MediaQuery.of(context).size.width % 20),
            itemCount: widget.tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.tasks[index];
              String formattedDate = DateFormat('d MMMM, EEEE HH:mm', 'ru_RU')
                  .format(task.createdAt);
              return InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Название задачи: ${task.title}"),
                      content: Text("Описание задачи: ${task.description}"),
                    );
                  },
                ),
                child: Container(
                  padding: EdgeInsets.all(13),
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Text(task.title,
                                  overflow: TextOverflow.ellipsis)),
                          Flexible(
                              flex: 2,
                              child: Text(formattedDate,
                                  overflow: TextOverflow.ellipsis))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        maxLines: 2,
                        task.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}



// leading: task.isFavorite
//                       ? const Icon(Icons.star)
//                       : const Icon(Icons.star_outline),

//  Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: task.isDone,
//                       onChanged: (bool? newValue) => {
//                         if (newValue != null)
//                           {
//                             context.read<TaskBloc>().add(
//                                   UpdateTaskEvent(
//                                     pageId: 1,
//                                     categoryId: task.categoryId,
//                                     taskId: task.id,
//                                     isDone: newValue,
//                                   ),
//                                 )
//                           },
//                       },
//                     ),
                  
//                   ],
//                 ),




  // PopupMenuButton<TaskActions>(
  //                     itemBuilder: (context) {
  //                       return [
  //                         PopupMenuItem(
  //                           value: TaskActions.edit,
  //                           onTap: () => _changeTaskInCategory(task: task),
  //                           child: const Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Icon(Icons.edit),
  //                               SizedBox(width: 5),
  //                               Text('Edit'),
  //                             ],
  //                           ),
  //                         ),
  //                         PopupMenuItem(
  //                           value: TaskActions.addToBookmarks,
  //                           onTap: () => context.read<TaskBloc>().add(
  //                                 UpdateTaskEvent(
  //                                     pageId: 1,
  //                                     taskId: task.id,
  //                                     categoryId: task.categoryId,
  //                                     isFavorite: !task.isFavorite),
  //                               ),
  //                           child: const Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Icon(Icons.bookmark_add_outlined),
  //                               SizedBox(width: 5),
  //                               Text('Add to bookmarks'),
  //                             ],
  //                           ),
  //                         ),
  //                         PopupMenuItem(
  //                           value: TaskActions.delete,
  //                           onTap: () => context.read<TaskBloc>().add(
  //                                 UpdateTaskEvent(
  //                                     pageId: 1,
  //                                     taskId: task.id,
  //                                     categoryId: task.categoryId,
  //                                     isDeleted: !task.isDeleted),
  //                               ),
  //                           child: const Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Icon(Icons.delete),
  //                               SizedBox(width: 5),
  //                               Text('Delete'),
  //                             ],
  //                           ),
  //                         ),
  //                       ];
  //                     },
  //                   )
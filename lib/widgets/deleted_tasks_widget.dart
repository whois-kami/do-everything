import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/common/app_constants.dart';
import 'package:todo_v2/common/app_theme.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/task_info_screen.dart';

class DeletedTasksWidget extends StatefulWidget {
  final List<TaskData> deletedTasks;
  const DeletedTasksWidget({
    super.key,
    required this.deletedTasks,
  });

  @override
  State<DeletedTasksWidget> createState() => _DeletedTasksWidgetState();
}

class _DeletedTasksWidgetState extends State<DeletedTasksWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width % 20,
                vertical: MediaQuery.of(context).size.width % 20),
            itemCount: widget.deletedTasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              TaskData task = widget.deletedTasks[index];
              String formattedDate = DateFormat('d MMMM, EEEE HH:mm', 'ru_RU')
                  .format(task.createdAt);
              return InkWell(
                onLongPress: () => context
                    .read<TaskBloc>()
                    .add(DeleteTaskEvent(taskId: task.id)),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TaskInfoScreen(
                          taskId: task.id,
                        ))),
                child: Container(
                  padding: const EdgeInsets.all(13),
                  height: 100,
                  width: 200,
                  decoration: AppConstants.boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Text(
                                task.title,
                                style: AppTheme
                                    .favoriteTextTheme.textTheme.displayLarge,
                              )),
                          Flexible(
                              flex: 2,
                              child: Text(
                                'Created at: $formattedDate',
                                style: AppTheme
                                    .favoriteTextTheme.textTheme.displaySmall,
                              ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        maxLines: 1,
                        'Deleted from: ${task.categoryName}',
                        style:
                            AppTheme.favoriteTextTheme.textTheme.displayMedium,
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

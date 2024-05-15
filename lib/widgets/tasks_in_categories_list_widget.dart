import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_v2/common/app_constants.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/task_info_screen.dart';

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
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                          Flexible(
                              flex: 2,
                              child: Text(
                                formattedDate,
                                style: Theme.of(context).textTheme.displaySmall,
                              ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        maxLines: 1,
                        task.description,
                        style: Theme.of(context).textTheme.displayMedium,
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

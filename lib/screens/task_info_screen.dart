import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/common/app_constants.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/change_task_screen.dart';
import 'package:todo_v2/widgets/conglaturations_widget.dart';

class TaskInfoScreen extends StatelessWidget {
  final int taskId;
  const TaskInfoScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          if (state.tasks.isNotEmpty) {
            TaskData? task;
            try {
              task = state.tasks.firstWhere((task) => task.id == taskId);
            } catch (e) {
              return const Scaffold(
                body: Center(child: Text('Task not found..Try again')),
              );
            }
            return Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                child: TaskInfoWidget(task: task),
              ),
              bottomNavigationBar: _BottomAppBar(task: task),
            );
          } else {
            return const Scaffold(body: Text('Something wrong..Try again'));
          }
        } else {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}

class TaskInfoWidget extends StatelessWidget {
  final TaskData task;
  const TaskInfoWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: (MediaQuery.of(context).size.height * 0.05),
          horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: 40),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined),
              const SizedBox(width: 5),
              Text(
                  !isDefaultDate(task.completedAt)
                      ? formatDate(task.completedAt)
                      : formatDate(task.createdAt),
                  // currently doesn't work
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 30),
            ],
          ),
          const SizedBox(height: 30),
          Text(task.description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  bool isDefaultDate(DateTime? date) {
    if (date == null) return false;
    return date.year == 2000 && date.month == 1 && date.day == 1;
  }

  String formatDate(DateTime data) =>
      DateFormat('d MMMM, EEEE HH:mm', 'ru_RU').format(data);
}

class _BottomAppBar extends StatelessWidget {
  final TaskData task;
  const _BottomAppBar({
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    bool taskDoneValue = task.isDone;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).bottomAppBarTheme.color,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => context.read<TaskBloc>().add(
                    UpdateTaskEvent(
                        taskId: task.id,
                        categoryId: task.categoryId,
                        isDeleted: !task.isDeleted),
                  ),
            ),
            const SizedBox(width: 10),
            IconButton(
              tooltip: 'Mark as favorite',
              icon: task.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: () => context.read<TaskBloc>().add(
                    UpdateTaskEvent(
                        taskId: task.id,
                        categoryId: task.categoryId,
                        isFavorite: !task.isFavorite),
                  ),
            ),
            const SizedBox(width: 10),
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                _changeTaskInCategory(
                    task: task, context: context, isUpdate: true);
              },
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              style: AppConstants.elevatedButtonStyle,
              onPressed: () {
                final rng = Random().nextInt(133);
                if (rng == 133) showCongratulationsDialog(context);
                bool newDoneStatus = !taskDoneValue;
                context.read<TaskBloc>().add(
                      UpdateTaskEvent(
                        categoryId: task.categoryId,
                        taskId: task.id,
                        isDone: !taskDoneValue,
                        completedAt: newDoneStatus ? DateTime.now() : null,
                      ),
                    );
              },
              child: taskDoneValue
                  ? const Text('Mark as incomplete',
                      style: TextStyle(color: Colors.white, fontSize: 16))
                  : const Text(
                      'Mark as complete',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _changeTaskInCategory({
    isUpdate,
    required TaskData task,
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return SingleChildScrollView(
          child: ChangeTaskScreen(
            task: task,
            isUpdate: isUpdate,
          ),
        );
      },
    );
  }
}

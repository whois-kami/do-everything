import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/widgets/completed_tasks_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadDoneTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const CircularProgressIndicator();
            } else if (state is TasksLoaded) {
              List<TaskData> tasks = state.tasks;
              return CompletedTasksListWidget(completedTasks: tasks);
            } else if (state is TasksError) {
              return Text('Произошла ошибка: ${state.message}');
            } else {
              return const Text('Начальное состояние блока');
            }
          },
        ),
      ),
    );
  }
}

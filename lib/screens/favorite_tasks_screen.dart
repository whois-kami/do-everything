import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/widgets/favorite_tasks_widget.dart';

class FavoriteTasksScreen extends StatefulWidget {
  const FavoriteTasksScreen({super.key});

  @override
  State<FavoriteTasksScreen> createState() => _FavoriteTasksScreenState();
}

class _FavoriteTasksScreenState extends State<FavoriteTasksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadFavoriteTasksEvent());
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
              return FavoriteTasksListWidget(favoriteTasks: tasks);
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

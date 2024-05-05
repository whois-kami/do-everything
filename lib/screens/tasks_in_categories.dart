import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/new_task_in_category_screen.dart';
import 'package:todo_v2/widgets/tasks_in_categories_list_widget.dart';

class TaskInCategoriesScreen extends StatelessWidget {
  const TaskInCategoriesScreen({super.key});

  void _createNewTaskInCategory(context, categoryId) {
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return SingleChildScrollView(
          child: AddNewTaskInCategoryScreen(
            categoryId: categoryId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as int?;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewTaskInCategory(context, data),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Tasks App'),
        actions: [
          IconButton(
            onPressed: () => _createNewTaskInCategory(context, data),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const CircularProgressIndicator();
            } else if (state is TasksLoaded) {
              List<TaskData> tasks = state.tasks;
              return TasksList(tasks: tasks);
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

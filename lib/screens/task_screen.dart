import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/models/task_model.dart';
import 'package:todo_v2/screens/new_task_screen.dart';
import 'package:todo_v2/widgets/taskslist_widget.dart';

class TasksScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  TasksScreen({super.key});

  void _createNewTask(context) {
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return const SingleChildScrollView(
          child: AddNewTaskScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewTask(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Tasks App'),
        actions: [
          IconButton(
            onPressed: () => (_createNewTask(context)),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            List<Task> allTasks = state.allTasks;
            return Column(
              children: [
                Chip(label: Text('Tasks: ${state.allTasks.length}')),
                TaskList(tasks: allTasks),
              ],
            );
          },
        ),
      ),
    );
  }
}

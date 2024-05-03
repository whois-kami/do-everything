import 'package:flutter/material.dart';
import 'package:todo_v2/screens/task_screen.dart';
import 'blocs/blocs_export.dart';

void main() {
  Bloc.observer = TaskBlocObserver();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}

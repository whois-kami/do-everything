import 'package:flutter/material.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/categories_screen.dart';
import 'package:todo_v2/screens/tasks_in_categories.dart';
import 'blocs/blocs_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase database = await AppDatabase.create();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TaskBloc>(
        create: (_) => TaskBloc(database),
      ),
      BlocProvider<CategoriesBloc>(
        create: (BuildContext context) => CategoriesBloc(database),
      ),
    ],
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/categories': (context) => const CategoriesScreen(),
        '/categories/tasks': (context) => const TaskInCategoriesScreen(),
      },
      home: const CategoriesScreen(),
    );
  }
}

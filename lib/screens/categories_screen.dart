import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/widgets/categories_list_widget.dart';
import 'package:todo_v2/widgets/query_tasks_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    context.read<CategoriesBloc>().add(LoadAllCategories());
    context.read<TaskBloc>().add(ResetTasksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
              child: TextField(
                style: const TextStyle(fontSize: 15),
                controller: _queryController,
                onChanged: (value) {
                  context.read<TaskBloc>().add(
                      LoadQueryLikeTasksEvent(query: _queryController.text));
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,
                      size: 25,
                      color: Theme.of(context)
                          .inputDecorationTheme
                          .prefixIconColor),
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                  hintText: 'Search tasks yopta',
                  contentPadding:
                      Theme.of(context).inputDecorationTheme.contentPadding,
                  border: Theme.of(context).inputDecorationTheme.border,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoaded) {
                    List<TaskCategory> categories = state.categories;
                    return CategoriesList(categories: categories);
                  } else if (state is CategoriesError) {
                    return Text('Произошла ошибка: ${state.message}');
                  } else {
                    return const Text('');
                  }
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TasksLoaded) {
                    List<TaskData> tasks = state.tasks;
                    return QueryTasksWidget(queryTasks: tasks);
                  } else if (state is TasksError) {
                    return Text('Произошла ошибка: ${state.message}');
                  } else {
                    return const Text('');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

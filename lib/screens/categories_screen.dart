import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/new_category_screen.dart';
import 'package:todo_v2/widgets/categories_list_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    context.read<CategoriesBloc>().add(LoadAllCategories());
    super.initState();
  }

  void _createNewCategory(context) {
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return const SingleChildScrollView(
          child: AddNewCategoryScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewCategory(context),
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const CircularProgressIndicator();
            } else if (state is CategoriesLoaded) {
              List<TaskCategory> categories = state.categories;
              return CategoriesList(categories: categories);
            } else if (state is CategoriesError) {
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

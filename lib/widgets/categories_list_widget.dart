import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/new_category_screen.dart';

class CategoriesList extends StatelessWidget {
  final List<TaskCategory> categories;

  const CategoriesList({
    super.key,
    required this.categories,
  });

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
    List<TaskCategory> reversedCategories = categories.reversed.toList();
    return ListView.separated(
      // for add new cagegory button
      itemCount: reversedCategories.length + 1,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        if (index < reversedCategories.length) {
          TaskCategory category = reversedCategories[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                  context.read<TaskBloc>().add(LoadTasksByCategoryEvent(index));
                  Navigator.pushNamed(context, '/categories/tasks',
                      arguments: index);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.red.shade50.withOpacity(0.3),
                  ),
                  child: Center(child: Text(category.name[0])),
                ),
              ),
              Text(category.name),
            ],
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => _createNewCategory(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

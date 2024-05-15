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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // for add new cagegory button
      itemCount: categories.length + 1,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        int displayIndex = categories.length - index - 1;
        if (index < categories.length) {
          TaskCategory category = categories[displayIndex];
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
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Center(
                      child: Text(
                    category.name[0],
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
                ),
              ),
              Text(
                category.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
              Text('add', style: Theme.of(context).textTheme.titleSmall)
            ],
          );
        }
      },
    );
  }
}

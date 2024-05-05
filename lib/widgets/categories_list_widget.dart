import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class CategoriesList extends StatelessWidget {
  final List<TaskCategory> categories;
  const CategoriesList({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              TaskCategory task = categories[index];
              return ListTile(
                  title: Text(task.name),
                  onTap: () {
                    context.read<TaskBloc>().add(LoadTasksByCategory(index));
                    Navigator.pushNamed(context, '/categories/tasks',
                        arguments: index);
                  });
            },
          ),
        ),
      ],
    );
  }
}

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
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          delegate: SliverChildBuilderDelegate((context, index) {
            final currentCategory = categories[index];
            final boxColor = generateColor(index);
            return GestureDetector(
              onTap: () {
                context.read<TaskBloc>().add(LoadTasksByCategoryEvent(index));
                Navigator.pushNamed(context, '/categories/tasks',
                    arguments: index);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: boxColor.withOpacity(1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset:
                              const Offset(5, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12)),
                  child: Center(
                    child: Text(currentCategory.name),
                  ),
                ),
              ),
            );
          }, childCount: categories.length),
        ),
      ],
    );
  }

  Color generateColor(int index) {
    int baseRed = 235;
    int baseGreen = 168;
    int baseBlue = 52;

    double factor = 1 - (index % 10) * 0.1;

    int red = (baseRed * factor).toInt().clamp(0, 255);
    int green = (baseGreen * factor).toInt().clamp(0, 255);
    int blue = (baseBlue * factor).toInt().clamp(0, 255);

    return Color.fromRGBO(red, green, blue, 1);
  }
}

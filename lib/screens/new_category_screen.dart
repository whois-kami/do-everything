import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/common/app_constants.dart';
import 'package:todo_v2/common/app_theme.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppConstants.addNewTaskBoxDecoration,
        child: Column(
          children: [
            const Text(
              'Add task',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: titleController,
                autofocus: true,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 19.0,
                ),
                decoration: InputDecoration(
                    label: const Text(
                      'Description',
                    ),
                    border: AppTheme.textFieldTheme.inputDecorationTheme.border,
                    isDense:
                        AppTheme.textFieldTheme.inputDecorationTheme.isDense,
                    contentPadding: AppTheme
                        .textFieldTheme.inputDecorationTheme.contentPadding),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('cancel')),
                ElevatedButton(
                  onPressed: () {
                    var categoryName = titleController.text;
                    context
                        .read<CategoriesBloc>()
                        .add(CreateNewCategory(name: categoryName));
                    Navigator.of(context).pop();
                  },
                  child: const Text('add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

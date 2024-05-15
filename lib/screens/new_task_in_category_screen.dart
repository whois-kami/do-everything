import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/common/app_constants.dart';
import 'package:todo_v2/common/app_theme.dart';

class AddNewTaskInCategoryScreen extends StatefulWidget {
  final int categoryId;

  const AddNewTaskInCategoryScreen({super.key, required this.categoryId});

  @override
  State<AddNewTaskInCategoryScreen> createState() =>
      _AddNewTaskInCategoryScreenState();
}

class _AddNewTaskInCategoryScreenState
    extends State<AddNewTaskInCategoryScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppConstants.addNewTaskBoxDecoration,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Add task',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 19.0,
                    ),
                    decoration: InputDecoration(
                      label: const Text(
                        'Title',
                      ),
                      border:
                          AppTheme.textFieldTheme.inputDecorationTheme.border,
                      isDense:
                          AppTheme.textFieldTheme.inputDecorationTheme.isDense,
                      contentPadding: AppTheme
                          .textFieldTheme.inputDecorationTheme.contentPadding,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: descController,
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
                        border:
                            AppTheme.textFieldTheme.inputDecorationTheme.border,
                        isDense: AppTheme
                            .textFieldTheme.inputDecorationTheme.isDense,
                        contentPadding: AppTheme.textFieldTheme
                            .inputDecorationTheme.contentPadding),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('cancel')),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(CreateTaskInCategoryEvent(
                          titleController.text,
                          descController.text,
                          widget.categoryId,
                          false,
                          false,
                        ));
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

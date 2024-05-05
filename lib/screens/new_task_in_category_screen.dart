import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';

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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Add category',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: descController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      border: OutlineInputBorder(),
                    ),
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

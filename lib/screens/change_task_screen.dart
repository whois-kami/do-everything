import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

class ChangeTaskScreen extends StatefulWidget {
  final TaskData task;

  const ChangeTaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<ChangeTaskScreen> createState() => _ChangeTaskScreenState();
}

class _ChangeTaskScreenState extends State<ChangeTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
    super.initState();
  }

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
              'Change task parms:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text('New title:'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _descController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text('New description:'),
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
                    context.read<TaskBloc>().add(UpdateTaskEvent(
                        taskId: widget.task.id,
                        categoryId: widget.task.categoryId,
                        title: _titleController.text,
                        description: _descController.text));
                    _titleController.clear();
                    _descController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}

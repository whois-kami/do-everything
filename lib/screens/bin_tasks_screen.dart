import 'package:flutter/material.dart';
import 'package:todo_v2/blocs/blocs_export.dart';
import 'package:todo_v2/data/local/db/app_db.dart';
import 'package:todo_v2/screens/home_screen.dart';
import 'package:todo_v2/widgets/deleted_tasks_widget.dart';

class BinTasksScreen extends StatefulWidget {
  const BinTasksScreen({super.key});

  @override
  State<BinTasksScreen> createState() => _BinTasksScreenState();
}

class _BinTasksScreenState extends State<BinTasksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadDeletedTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SafeArea(
          child: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              );
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Made with soul',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20),
              ),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen()),
                ModalRoute.withName('/'),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TasksLoaded) {
              List<TaskData> tasks = state.tasks;
              return DeletedTasksListWidget(deletedTasks: tasks);
            } else if (state is TasksError) {
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

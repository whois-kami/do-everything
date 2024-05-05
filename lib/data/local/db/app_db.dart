import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_db.g.dart';

class TaskCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get categoryId =>
      integer().customConstraint('REFERENCES TaskCategories(id)')();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [TaskCategories, Task])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static Future<AppDatabase> create() async {
    final executor = await _openConnection();
    return AppDatabase(executor);
  }

  @override
  int get schemaVersion => 1;

  static Future<QueryExecutor> _openConnection() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  }

  Future<List<TaskData>> getTasksByCategory(int categoryId) async {
    return (select(task)..where((t) => t.categoryId.equals(categoryId))).get();
  }

  Future<List<TaskCategory>> getAllCategories() async {
    return (select(taskCategories)).get();
  }

  Future<void> createCategory(String name) async {
    await into(taskCategories)
        .insert(TaskCategoriesCompanion.insert(name: name));
  }

  Future<void> createTaskInCategory(
      String name, String description, int categoryId) async {
    await into(task).insert(TaskCompanion.insert(
      title: name,
      description: description,
      categoryId: categoryId,
    ));
  }
}

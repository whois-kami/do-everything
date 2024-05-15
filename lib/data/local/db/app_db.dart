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
  TextColumn get categoryName => text().nullable()();
  IntColumn get categoryId =>
      integer().customConstraint('REFERENCES TaskCategories(id)')();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt =>
      dateTime().withDefault(Constant(DateTime(2000, 1, 1)))();
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

  static Future<void> deleteDatabase() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<List<TaskData>> getTasksByCategory(int categoryId) async {
    return (select(task)
          ..where((t) =>
              t.categoryId.equals(categoryId) &
              t.isDone.equals(false) &
              t.isDeleted.equals(false)))
        .get();
  }

  Future<List<TaskCategory>> getAllCategories() async {
    return (select(taskCategories)).get();
  }

  Future<List<TaskData>> getAllTasks() async {
    return (select(task)).get();
  }

  Future<void> createCategory(String name) async {
    await into(taskCategories)
        .insert(TaskCategoriesCompanion.insert(name: name));
  }

  Future<void> createTaskInCategory(String name, String description,
      int categoryId, bool isDeleted, bool isDone) async {
    final categoryName = await (select(taskCategories)
          ..where((cat) => cat.id.equals(categoryId + 1)))
        .map((data) => data.name)
        .getSingleOrNull();
    await into(task).insert(TaskCompanion.insert(
      title: name,
      description: description,
      categoryName: Value(categoryName),
      categoryId: categoryId,
      isDeleted: Value(isDeleted),
      isDone: Value(isDone),
    ));
  }

  Future<List<TaskData>> getDeletedTasks() async {
    return (select(task)..where((t) => t.isDeleted.equals(true))).get();
  }

  Future<List<TaskData>> getDoneTasks() async {
    return (select(task)..where((t) => t.isDone.equals(true))).get();
  }

  Future<List<TaskData>> getFavoriteTasks() async {
    return (select(task)..where((t) => t.isFavorite.equals(true))).get();
  }

  Future<TaskCategory> getCategoryById(int categoryId) async {
    return (select(taskCategories)
          ..where((categ) => categ.id.equals(categoryId)))
        .getSingle();
  }

  Future<void> updateTask(int taskId,
      {bool? isDone,
      bool? isDeleted,
      bool? isFavorite,
      String? title,
      String? description,
      DateTime? completedAt}) async {
    var updateBuilder = const TaskCompanion();
    if (isDone != null) {
      updateBuilder = updateBuilder.copyWith(isDone: Value(isDone));
      if (isDone == true && completedAt == null) {
        updateBuilder =
            updateBuilder.copyWith(completedAt: Value(DateTime.now()));
      } else if (isDone == false) {
        updateBuilder =
            updateBuilder.copyWith(completedAt: const Value.absent());
      }
    }
    if (isDeleted != null) {
      updateBuilder = updateBuilder.copyWith(isDeleted: Value(isDeleted));
    }
    if (isFavorite != null) {
      updateBuilder = updateBuilder.copyWith(isFavorite: Value(isFavorite));
    }
    if (title != null) {
      updateBuilder = updateBuilder.copyWith(title: Value(title));
    }
    if (description != null) {
      updateBuilder = updateBuilder.copyWith(description: Value(description));
    }

    if (updateBuilder != const TaskCompanion()) {
      await (update(task)..where((t) => t.id.equals(taskId)))
          .write(updateBuilder);
    }
  }

  Future<List<TaskData>> getTasksByQuery(String query) async {
    final lowercaseQuery = query.toLowerCase();
    if (query.isEmpty) {
      return [];
    } else {
      return (select(task)
            ..where((t) => t.title.lower().like('%$lowercaseQuery%')))
          .get();
    }
  }

  Future<TaskData> getTaskById(int id) {
    return (select(task)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> deleteTask(int id) {
    return (delete(task)..where((t) => t.id.equals(id))).go();
  }
}

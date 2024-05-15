import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AppDatabase database;

  TaskBloc(this.database) : super(const TaskInitialState()) {
    on<ResetTasksEvent>(_onResetTasks);
    on<CreateTaskInCategoryEvent>(_onCreateTaskInCategory);
    on<LoadTasksByCategoryEvent>(_onLoadTasksByCategory);
    on<LoadDoneTasksEvent>(_onLoadDoneTaks);
    on<GetAllTasksEvent>(_onGetAllTasksEvent);
    on<LoadDeletedTasksEvent>(_onLoadDeletedTaks);
    on<LoadFavoriteTasksEvent>(_onLoadFavoriteTaks);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<LoadQueryLikeTasksEvent>(_onLoadQueryLikeTasks);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  Future<void> _onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      await database.deleteTask(event.taskId);
      final tasks = await database.getDeletedTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onGetAllTasksEvent(
      GetAllTasksEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getAllTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onResetTasks(
      ResetTasksEvent event, Emitter<TaskState> emit) async {
    emit(const TasksLoaded([]));
  }

  Future<void> _onCreateTaskInCategory(
      CreateTaskInCategoryEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      await database.createTaskInCategory(
        event.name,
        event.description,
        event.categoryId,
        event.isDeleted,
        event.isDone,
      );
      final tasks = await database.getTasksByCategory(event.categoryId);
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onLoadTasksByCategory(
      LoadTasksByCategoryEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getTasksByCategory(event.categoryId);
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onLoadDoneTaks(
      LoadDoneTasksEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getDoneTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      TasksError(e.toString());
    }
  }

  Future<void> _onLoadDeletedTaks(
      LoadDeletedTasksEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getDeletedTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      TasksError(e.toString());
    }
  }

  Future<void> _onLoadFavoriteTaks(
      LoadFavoriteTasksEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getFavoriteTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      TasksError(e.toString());
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await database.updateTask(
        event.taskId,
        title: event.title,
        description: event.description,
        isDone: event.isDone,
        isDeleted: event.isDeleted,
        isFavorite: event.isFavorite,
        completedAt: event.completedAt,
      );
      // PageId was added to understand what page we are on.
      // To load only tasks where we are, with no reactions to changes.
      emit(TasksLoading());
      var task = await database.getTaskById(event.taskId);
      emit(TasksLoaded([task]));
    } catch (e) {
      TasksError(e.toString());
    }
  }

  Future<void> _onLoadQueryLikeTasks(
      LoadQueryLikeTasksEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getTasksByQuery(event.query);
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}

// class TaskBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     // if (bloc is Cubit) print(change);
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     // print(transition);
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AppDatabase database;

  TaskBloc(this.database) : super(const TaskInitialState()) {
    on<CreateTaskInCategoryEvent>(_onCreateTaskInCategory);
    on<LoadTasksByCategory>(_loadTasksByCategory);
  }

  Future<void> _onCreateTaskInCategory(
      CreateTaskInCategoryEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      await database.createTaskInCategory(
          event.name, event.description, event.categoryId);
      final tasks = await database.getTasksByCategory(event.categoryId);
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _loadTasksByCategory(
      LoadTasksByCategory event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await database.getTasksByCategory(event.categoryId);
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

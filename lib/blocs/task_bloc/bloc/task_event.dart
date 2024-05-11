// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class ResetTasksEvent extends TaskEvent {}

class GetAllTasksEvent extends TaskEvent {}


class LoadTasksByCategoryEvent extends TaskEvent {
  final int categoryId;

  const LoadTasksByCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class CreateTaskInCategoryEvent extends TaskEvent {
  final String name;
  final String description;
  final int categoryId;
  final bool isDone;
  final bool isDeleted;

  const CreateTaskInCategoryEvent(
    this.name,
    this.description,
    this.categoryId,
    this.isDone,
    this.isDeleted,
  );

  @override
  List<Object> get props => [name, description, categoryId];
}

class LoadDoneTasksEvent extends TaskEvent {
  @override
  List<Object> get props => [];
}

class LoadDeletedTasksEvent extends TaskEvent {
  @override
  List<Object> get props => [];
}

class LoadFavoriteTasksEvent extends TaskEvent {
  @override
  List<Object> get props => [];
}

class LoadQueryLikeTasksEvent extends TaskEvent {
  final String query;
  const LoadQueryLikeTasksEvent({
    required this.query,
  });
  @override
  List<Object> get props => [query];
}

class UpdateTaskEvent extends TaskEvent {
  final int taskId;
  final int categoryId;
  final int? pageId;
  final String? title;
  final String? description;
  final bool? isDone;
  final bool? isDeleted;
  final bool? isFavorite;

  const UpdateTaskEvent({
    required this.taskId,
    required this.categoryId,
    this.pageId,
    this.title,
    this.description,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  });
  @override
  List<Object> get props => [
        taskId,
        isDone ?? false,
        isDeleted ?? false,
        isFavorite ?? false,
      ];
}

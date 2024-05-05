part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}


class LoadTasksByCategory extends TaskEvent {
  final int categoryId;

  const LoadTasksByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class CreateTaskInCategoryEvent extends TaskEvent {
  final String name;
  final String description;
  final int categoryId;

  const CreateTaskInCategoryEvent(this.name, this.description, this.categoryId);

  @override
  List<Object> get props => [name, description, categoryId];
}


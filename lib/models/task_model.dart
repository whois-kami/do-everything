import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final bool isDone;
  final bool isDeleted;

  const Task({
    required this.title,
    bool? isDone,
    bool? isDeleted,
  })  : isDone = isDone ?? false,
        isDeleted = isDeleted ?? false;

  Task copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object> get props => [title, isDone, isDeleted];
}

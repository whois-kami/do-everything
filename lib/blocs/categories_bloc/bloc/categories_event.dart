part of 'categories_bloc.dart';

class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CreateNewCategory extends CategoriesEvent {
  final String name;
  const CreateNewCategory({
    required this.name,
  });
  @override
  List<Object> get props => [name];
}

class LoadAllCategories  extends CategoriesEvent {
  @override
  List<Object> get props => [];
}

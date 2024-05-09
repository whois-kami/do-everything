import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_v2/data/local/db/app_db.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  AppDatabase database;
  CategoriesBloc(this.database) : super(const CategoriesInitialState()) {
    on<CreateNewCategory>(_onCreateNewCategory);
    on<LoadAllCategories>(_onLoadAllCategories);
    on<GetCategoryById>(_getCategoryById);
  }

  Future<void> _onCreateNewCategory(
      CreateNewCategory event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      await database.createCategory(event.name);
      final categories = await database.getAllCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> _onLoadAllCategories(
      LoadAllCategories event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      final categories = await database.getAllCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> _getCategoryById(
      GetCategoryById event, Emitter<CategoriesState> emit) async {
    try {
      final category = await database.getCategoryById(event.categoryId);
      emit(CategoriesLoaded([category]));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}

// class CategoriesBlocObserver extends BlocObserver {
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

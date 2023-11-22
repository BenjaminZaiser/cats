import 'package:cats/model/cat.dart';
import 'package:cats/repository/cats_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CatsController extends Cubit<BaseState> {
  final _repository = GetIt.I.get<CatsRepository>();

  CatsController() : super(InitialState());

  Future<void> loadCats() async {
    emit(LoadingState());
    final cat = await _repository.loadRandomCat();
    emit(CatLoadedState(cat: cat));
  }
}

abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class CatLoadedState extends BaseState {
  final Cat cat;

  CatLoadedState({required this.cat});
}

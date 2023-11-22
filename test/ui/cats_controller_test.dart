import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:cats/ui/cats_controller.dart';
import 'package:cats/model/cat.dart';
import 'package:cats/repository/cats_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CatsRepository catsRepository;

  setUp(() {
    catsRepository = MockCatsRepository();
    GetIt.I.registerSingleton<CatsRepository>(catsRepository);
  });

  tearDown(() {
    GetIt.I.unregister<CatsRepository>();
  });

  blocTest<CatsController, BaseState>(
    'load cats',
    setUp: () {
      when(() => catsRepository.loadRandomCat())
          .thenAnswer((_) => Future.value(Cat(image: utf8.encode("asdf"))));
    },
    build: () => CatsController(),
    act: (bloc) async {
      await bloc.loadCats();
    },
    expect: () => [
      isA<LoadingState>(),
      isA<CatLoadedState>(),
    ],
  );
}

class MockCatsRepository extends Mock implements CatsRepository {}

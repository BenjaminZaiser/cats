import 'dart:io';
import 'package:cats/ui/cats_controller.dart';
import 'package:cats/model/cat.dart';
import 'package:cats/ui/cats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CatsController mockBloc;

  setUp(() {
    mockBloc = MockCatsController();
  });

  testWidgets('InitialState shows text', (WidgetTester tester) async {
    final state = InitialState();
    when(() => mockBloc.state).thenReturn(state);
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider.value(value: mockBloc, child: const CatsScreen()),
    ));

    expect(find.text("No cat here"), findsOneWidget);
  });

  testWidgets('Loading state shows CircularProgressIndicator', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadingState());
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(LoadingState()));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider.value(value: mockBloc, child: const CatsScreen()),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CatLoadedState shows image', (WidgetTester tester) async {
    final state = CatLoadedState(cat: Cat(image: File('test/assets/cat.jpg').readAsBytesSync()));
    when(() => mockBloc.state).thenReturn(state);
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider.value(value: mockBloc, child: const CatsScreen()),
    ));

    expect(find.byType(Image), findsOneWidget);
  });
}

class MockCatsController extends Mock implements CatsController {}

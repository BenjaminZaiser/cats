import 'package:cats/ui/cats_controller.dart';
import 'package:cats/repository/cats_repository.dart';
import 'package:cats/ui/cats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerSingleton(CatsRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (_) => CatsController(),
        child: const CatsScreen(),
      ),
    );
  }
}

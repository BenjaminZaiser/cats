import 'package:cats/ui/cats_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsScreen extends StatelessWidget {
  const CatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cats!")),
      body: Center(
        child: BlocBuilder<CatsController, BaseState>(builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CatLoadedState) {
            return Image.memory(state.cat.image);
          }
          return const Text("No cat here");
        }),
      ),
      bottomNavigationBar: OutlinedButton(
          onPressed: () => BlocProvider.of<CatsController>(context).loadCats(),
          child: const Text("Load new cat")),
    );
  }
}

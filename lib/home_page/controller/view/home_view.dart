import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/widgets/pokeball_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFoundPokemon) {
          Navigator.of(context).pushNamed('pokemon_at_stop');
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Pokemon'),
                centerTitle: true,
              ),
              body: GestureDetector(
                onTap:(){
                  if(state.nearAStop) {
                    context.read<HomeBloc>().add(FindPokemon());
                  }
                },
                child: PokeballWidget(
                  isColored: state.nearAStop,
                ),
              ),
            ),
          );
        } else {
          return const Text("bad state");
        }
      },
    );
  }
}

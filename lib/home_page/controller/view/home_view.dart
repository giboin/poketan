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
              floatingActionButton: SizedBox(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/backpack.png"),
                  onPressed: (){
                    Navigator.of(context).pushNamed('owned_pokemons');
                  },
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/nantes_map_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: GestureDetector(
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
            ),
          );
        } else {
          return const Text("Loading");
        }
      },
    );
  }
}

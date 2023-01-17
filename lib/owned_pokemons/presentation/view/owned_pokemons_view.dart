import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/inventory_pokemon_card.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class OwnedPokemons extends StatelessWidget {
  const OwnedPokemons({super.key});

  @override
  Widget build(BuildContext context) {

    List<Pokemon> myPokemons = context.read<OwnedPokemonsBloc>().state.pokeList;
    //List<Pokemon> myTeam = context.read<OwnedPokemonsBloc>().state.pokeTeam;


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.home),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/ronflex_background.png"),
          ),
        ),
        child: BlocConsumer<OwnedPokemonsBloc, OwnedPokemonsState>(
          listener: (context, state) {
            myPokemons = state.pokeList;
            //myTeam = state.pokeTeam;

          },
          builder: (context, state) {
            return SafeArea(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: Text(
                  "Mes Pokemouns",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: myPokemons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (ctx, int index) {
                      return InventoryPokemonCard(pokemon: myPokemons[index]);
                    }),
              ),
            ]),
          );
          },
        ),
      ),
    );
  }
}

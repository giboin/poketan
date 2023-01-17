import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/inventory_pokemon_card.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/pick_starter_button.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class OwnedPokemons extends StatelessWidget {
  const OwnedPokemons({super.key});

  @override
  Widget build(BuildContext context) {
    List<Pokemon> starters = [
      Pokemon(
          name: "Bulbizarre",
          level: 5,
          pictureUrl:
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
          pokedexId: 1),
      Pokemon(
          name: "Salamèche",
          level: 5,
          pictureUrl:
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
          pokedexId: 4),
      Pokemon(
          name: "Carapuce",
          level: 5,
          pictureUrl:
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
          pokedexId: 7),
    ];
    //List<Pokemon> myTeam = context.read<OwnedPokemonsBloc>().state.pokeTeam;

    return BlocBuilder<OwnedPokemonsBloc, OwnedPokemonsState>(builder: (context, state) {
      if (state is OwnedPokemonsInitial){
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
            child: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                    child: Text(
                      "Choisis ton premier pokémon",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: starters.length,
                        itemBuilder: (ctx, int index) {
                          return PickStarterButton(pokemon: starters[index]);
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      else {
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
                          itemCount: state.pokeList.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (ctx, int index) {
                            return InventoryPokemonCard(
                                pokemon: state.pokeList[index]);
                          }),
                    ),
                  ]),
                );
              },
            ),
          ),
        );
      }
    });
  }
}

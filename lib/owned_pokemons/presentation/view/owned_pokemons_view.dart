import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/inventory_pokemon_card.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/pick_starter_button.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

/// The view that displays the owned pokemons
/// and the poketeam
class OwnedPokemons extends StatelessWidget {
  OwnedPokemons({super.key});

  /// The list of the 3 starter pokemons
  /// TODO: move this to a repository
  final List<Pokemon> starters = [
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

  @override
  Widget build(BuildContext context) {
    // listen to the state of the bloc and build the view accordingly
    return BlocBuilder<OwnedPokemonsBloc, OwnedPokemonsState>(
        builder: (context, state) {
      // if the state is OwnedPokemonsInitial, we display the
      // list of starters that the user can choose from
      if (state is OwnedPokemonsChooseStarter) {
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
                    // display the list of starters
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
      // if the state is PokemonUpdated, we display the list of owned pokemons
      else if (state is PokemonUpdated) {
        List<Pokemon> pokeTeam = state.pokeTeam;
        List<Pokemon> pokeList = List.from(state.pokeList)
          ..sort((a, b) =>
              (pokeTeam.contains(b) ? 1 : 0) - (pokeTeam.contains(a) ? 1 : 0));

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
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: Text(
                    "Mes Pokemouns",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Expanded(
                  // display the list of owned pokemons
                  child: GridView.builder(
                      itemCount: state.pokeList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (ctx, int index) {
                        return InventoryPokemonCard(pokemon: pokeList[index]);
                      }),
                ),
              ]),
            ),
          ),
        );
      } else {
        // should never happen, but just in case
        // and also to avoid a warning
        // TODO: replace if / else if by a switch
        return Text("${state.runtimeType}");
      }
    });
  }
}

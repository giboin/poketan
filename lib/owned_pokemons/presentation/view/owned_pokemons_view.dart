import 'package:flutter/material.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/inventory_pokemon_card.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class OwnedPokemons extends StatelessWidget {
  OwnedPokemons({super.key});

  final myPokemons = <Pokemon>[
    Pokemon(
        name: "Salamouche",
        level: 2,
        pokedexId: 4,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
    Pokemon(
        name: "Bulbazar",
        level: 50,
        pokedexId: 1,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
    Pokemon(
        name: "Carapute",
        level: 37,
        pokedexId: 7,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
  ];

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: myPokemons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (ctx, int index) {
                    return InventoryPokemonCard(pokemon: myPokemons[index]);
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

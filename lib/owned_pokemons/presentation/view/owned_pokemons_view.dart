import 'package:flutter/material.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/inventory_pokemon_card.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class OwnedPokemons extends StatelessWidget {
  OwnedPokemons({super.key});

  final myPokemons = <Pokemon>[
    Pokemon(
        name: "Salamouche",
        level: 2,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
    Pokemon(
        name: "Bulbazar",
        level: 50,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
    Pokemon(
        name: "Carapute",
        level: 37,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const Text("Mes Pokemouns"),
          const Padding(padding: EdgeInsets.all(10)),
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
    );
  }
}

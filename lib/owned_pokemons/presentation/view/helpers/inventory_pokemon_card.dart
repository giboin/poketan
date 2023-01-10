import 'package:flutter/material.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class InventoryPokemonCard extends StatelessWidget {
  const InventoryPokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(pokemon.name),
        subtitle: Column(
          children: [
            Image.network(pokemon.pictureUrl),
            Text("niveau ${pokemon.level}")
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class InventoryPokemonCard extends StatelessWidget {
  const InventoryPokemonCard({
    Key? key,
    required this.pokemon,
    required this.team,
  }) : super(key: key);

  final Pokemon pokemon;
  final bool team;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Image.network(pokemon.pictureUrl),
            Text("${pokemon.name} niveau ${pokemon.level}", style: TextStyle(fontStyle: team?FontStyle.italic:FontStyle.normal),)
          ],
        ),
      
    );
  }
}

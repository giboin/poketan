import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';

/// A button that allows the user to pick a starter pokemon
class PickStarterButton extends StatelessWidget {
  /// The pokemon that the user can pick
  final Pokemon pokemon;

  const PickStarterButton({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // notify the bloc that a new pokemon has been added
        context.read<OwnedPokemonsBloc>().add(NewPokemon(pokemon: pokemon));
        List<Pokemon> initialTeam = [pokemon];
        // notify the bloc that the team has been changed
        context.read<OwnedPokemonsBloc>().add(NewTeam(newTeam: initialTeam));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Card(
              child: Column(
                children: [
                  Image.network(pokemon.pictureUrl),
                  Text("${pokemon.name} niveau ${pokemon.level}")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

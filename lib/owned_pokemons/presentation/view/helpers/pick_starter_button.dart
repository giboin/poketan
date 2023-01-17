import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';

class PickStarterButton extends StatefulWidget {
  final Pokemon pokemon;

  const PickStarterButton({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PickStarterButton> createState() => _PickStarterButtonState();
}

class _PickStarterButtonState extends State<PickStarterButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        context.read<OwnedPokemonsBloc>().add(NewPokemon(pokemon: widget.pokemon));
        List<Pokemon> initialTeam = [widget.pokemon];
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
                  Image.network(widget.pokemon.pictureUrl),
                  Text("${widget.pokemon.name} niveau ${widget.pokemon.level}")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

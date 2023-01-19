import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/view/helpers/pokemon_details.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

// TODO: change this to a stateless widget and use a bloc consumer instead
/// The widget that displays a pokemon in the inventory
class InventoryPokemonCard extends StatefulWidget {
  const InventoryPokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  /// The pokemon to display
  final Pokemon pokemon;

  @override
  State<InventoryPokemonCard> createState() => _InventoryPokemonCardState();
}

/// The state of the [InventoryPokemonCard] widget
class _InventoryPokemonCardState extends State<InventoryPokemonCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedPokemonsBloc, OwnedPokemonsState>(
        builder: (context, state) {
      if (state is PokemonUpdated) {
        bool isInTeam = state.pokeTeam
            .map((e) => e.pokedexId)
            .contains(widget.pokemon.pokedexId);
        return Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetails(pokemon:widget.pokemon)),);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(widget.pokemon.pictureUrl),
                          Text("${widget.pokemon.name} niveau ${widget.pokemon.level}"),
                          Padding(
                            padding: const EdgeInsets.only(top:5.0, left:8.0, right: 8.0),
                            child: LinearProgressIndicator(
                              value:(widget.pokemon.xp-(pow(widget.pokemon.level, 3)))/(pow(widget.pokemon.level+1, 3)-pow(widget.pokemon.level,3)),
                              backgroundColor: Colors.grey, 
                              color: Colors.blueAccent,
                              ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    List<Pokemon> newTeam = state.pokeTeam;
                    if (isInTeam && state.pokeTeam.length > 1) {
                      newTeam.removeWhere((element) =>
                          element.pokedexId == widget.pokemon.pokedexId);
                      // TODO: change this with a state of bloc
                      // or in the constructor of this stalesless widget
                      setState(() {
                        isInTeam = false;
                      });
                      // notify the bloc that the team has changed
                      context
                          .read<OwnedPokemonsBloc>()
                          .add(NewTeam(newTeam: newTeam));
                    } else if (!isInTeam && newTeam.length < 6) {
                      newTeam.add(widget.pokemon);
                      // TODO: same as above
                      setState(() {
                        isInTeam = true;
                      });
                      // notify the bloc that the team has changed
                      context
                          .read<OwnedPokemonsBloc>()
                          .add(NewTeam(newTeam: newTeam));
                    }
                  },
                  icon: Icon(
                    Icons.star,
                    color: isInTeam ? Colors.amber : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return Text("${state.runtimeType}");
      }
    });
  }
}

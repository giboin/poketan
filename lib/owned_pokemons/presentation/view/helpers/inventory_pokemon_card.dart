import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class InventoryPokemonCard extends StatefulWidget {
  const InventoryPokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  State<InventoryPokemonCard> createState() => _InventoryPokemonCardState();
}

class _InventoryPokemonCardState extends State<InventoryPokemonCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedPokemonsBloc, OwnedPokemonsState>(
     builder:(context, state) {
      bool isInTeam = state.pokeTeam.map((e) => e.pokedexId).contains(widget.pokemon.pokedexId);
      return Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
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
              IconButton(
                onPressed: () {
                  List<Pokemon> newTeam = state.pokeTeam;
                  if (isInTeam) {
                    newTeam.removeWhere(
                        (element) => element.pokedexId == widget.pokemon.pokedexId);
                        setState(() {
                      isInTeam=false;
                    });
                    context
                        .read<OwnedPokemonsBloc>()
                        .add(NewTeam(newTeam: newTeam));
                  } else if (newTeam.length < 6) {
                    newTeam.add(widget.pokemon);
                    setState(() {
                      isInTeam=true;
                    });
                    context
                        .read<OwnedPokemonsBloc>()
                        .add(NewTeam(newTeam: newTeam));
                  }
                },
                icon: Icon(
                  Icons.star,
                  color:
                      isInTeam
                          ? Colors.amber
                          : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';

import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class FightDialog extends StatefulWidget {
  final AtStopState atStopState;

  const FightDialog({Key? key, required this.atStopState}) : super(key: key);

  @override
  State<FightDialog> createState() => _FightDialogState();
}

class _FightDialogState extends State<FightDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child:Column(
            children: [
              const Icon(
            Icons.bolt_sharp,
            size: 50.0,
            color: Colors.amber,
          ),
          Image.network(widget.atStopState.wildPokemon.pictureUrl),
          Text(
            '${widget.atStopState.wildPokemon.name} - level ${widget.atStopState.wildPokemon.level}',
            style: const TextStyle(fontSize: 25.0),
          ),
          const Padding(padding: EdgeInsets.all(10)),
              const Text(
                'Avec qui vaincre ce pokémon ?',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  width: 600.0,
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView.builder(
                      itemCount: widget.atStopState.pokelist.length,
                      itemBuilder: (context, index) {
                        Pokemon pokemon = widget.atStopState.pokelist[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Card(
                            color: Colors.yellow,
                            child: ListTile(
                              title: Text(
                                "${pokemon.name}, niveau ${pokemon.level}",
                                style:
                                    const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              trailing: Image.network(pokemon.pictureUrl),
                              onTap: () {
                                context
                                    .read<AtStopBloc>()
                                    .add(PokemonChosen(pokemon: pokemon));
                              },
                            ),
                          ),
                        );
                      }),
                ),
              ),
              TextButton(
              onPressed: () {
                context.read<AtStopBloc>().add(const GoToAtStopBlocInitial());
              },
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),
            ),
          ],
      ),
    );
  }
}

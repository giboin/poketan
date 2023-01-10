import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';

import '../pokemon_at_stop/domain/pokemon.dart';

class FightDialog extends StatefulWidget {
  final AtStopState atStopState;

  const FightDialog({Key? key, required this.atStopState}) : super(key: key);

  @override
  State<FightDialog> createState() => _FightDialogState();
}

class _FightDialogState extends State<FightDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AlertDialog(
        icon: const Icon(Icons.bolt_sharp, size: 50.0, color: Colors.amber,),
        title: Text('${widget.atStopState.wildPokemon.name} - level ${widget.atStopState.wildPokemon.level}', style: const TextStyle(fontSize: 25.0),),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30.0),
        content: Column(
          children: [
            const Text('Avec qui vaincre ce pokémon ?', style: TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 15.0),),
            const SizedBox(height: 20.0,),
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
                                "${pokemon.name}, niveau ${pokemon.level}", style: const TextStyle(fontWeight: FontWeight.w500),),
                            trailing: Image.network(pokemon.pictureUrl),
                            onTap: () {
                              context
                                  .read<AtStopBloc>()
                                  .add(ChoosePokemon(pokemon: pokemon));
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.only(bottom: 10.0, right: 20.0),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
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

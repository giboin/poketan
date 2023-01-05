import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

import 'controller/at_stop_bloc.dart';

class PokemonsAtStopView extends StatelessWidget {
  const PokemonsAtStopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AtStopBloc, AtStopState>(listener: (context, state) {
      if (state is AtStopInitialState) {}
    }, builder: (context, state) {
      if (state is AtStopInitialState) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text('Arrêt ${state.stopName}'),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text("Un pokemon sauvage apparait!"),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(state.wildPokemon.pictureUrl),
                  ),
                  Text(
                      "${state.wildPokemon.name}, niveau ${state.wildPokemon.level}"),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                  ),
                  const Text("Avec qui voulez vous lui péter la gueule?"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.pokelist.length,
                        itemBuilder: (context, index) {
                          Pokemon pokemon = state.pokelist[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                  "${pokemon.name}, niveau ${pokemon.level}"),
                              trailing: Image.network(pokemon.pictureUrl),
                              onTap: () {},
                            ),
                          );
                        }),
                  ),
                ],
              )),
        ));
      } else {
        return const Text('bad state');
      }
    });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

import 'controller/at_stop_bloc.dart';

class PokemonsAtStopScreen extends StatelessWidget {
  const PokemonsAtStopScreen({
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
            title: const Text('Pokemon'),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  itemCount: state.pokelist.length,
                  itemBuilder: (context, index) {
                    Pokemon pokemon = state.pokelist[index];
                    return Card(
                      child: ListTile(
                        title: Text("${pokemon.name}, niveau ${pokemon.level}"),
                        trailing: Image.network(pokemon.pictureUrl),
                      ),
                    );
                  })),
        ));
      } else {
        return const Text('bad state');
      }
    });
  }
}

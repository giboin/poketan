import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/Pokemon.dart';
import 'controller/at_stop_bloc.dart';

class PokemonsAtStopScreen extends StatelessWidget {

  String stopId = "";
  List<Pokemon> pokelist = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AtStopBloc, AtStopState>(
        listener: (context, state) {
          if (state is AtStopInitialState) {
            pokelist = state.pokelist;
            stopId = state.stopId;
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Pokemon'), centerTitle: true,),
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                        itemCount: pokelist.length,
                        itemBuilder: (context, index) {
                          Pokemon pokemon = pokelist[index];
                          return Card(
                            child: ListTile(
                              title: Text("${pokemon.name}, niveau ${pokemon.level}"),
                              trailing: Image.network(pokemon.pictureUrl),
                            ),
                          );
                        }
                    )
                ),
              )
          );
        }
    );
  }
}

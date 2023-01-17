import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'at_stop_event.dart';
part 'at_stop_state.dart';

class AtStopBloc extends Bloc<AtStopEvent, AtStopState> {
  final String serverUrl = "https://hackathon-server.osc-fr1.scalingo.io/";

  AtStopBloc(
      {required String stopName,
      required Pokemon wildPokemon,
      required List<Pokemon> pokelist})
      : super(AtStopInitialState(
            stopName: stopName, wildPokemon: wildPokemon, pokelist: pokelist)) {
    on<ChoosePokemon>((event, emit) async {
      Map<String, dynamic> body = {
        'owned_pokemon': event.pokemon.toMap(),
        'wild_pokemon': wildPokemon.toMap(),
      };

      String encodedBody = jsonEncode(body);
      http.Response res = await http.post(Uri.parse('$serverUrl/fight'),
          headers: {"Content-Type": "application/json"}, body: encodedBody);
      Map<String, dynamic> json = jsonDecode(res.body);
      if (kDebugMode) {
        print(json);
      }
      bool winnerBool = json["final_state"] == "you win";
      event.pokemon.xp = json["new_xp"];
      event.pokemon.xp = json["new_lvl"];

      Pokemon updatedPokemon = Pokemon.withXp(
          level: json["new_lvl"],
          name: event.pokemon.name,
          pictureUrl: event.pokemon.pictureUrl,
          xp: json["new_xp"],
          pokedexId: event.pokemon.pokedexId);
      List<Pokemon> newPokelist = pokelist.map<Pokemon>((e) {
        if (e.name == event.pokemon.name) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();
      emit(FightFinished(
          pokelist: newPokelist,
          stopName: state.stopName,
          wildPokemon: state.wildPokemon,
          chosenPokemon: updatedPokemon,
          winner: winnerBool,
          xpWon: json["xp_earned"]));
    });
  }
}

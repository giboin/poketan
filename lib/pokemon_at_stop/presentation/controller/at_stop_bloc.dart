import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'at_stop_event.dart';
part 'at_stop_state.dart';

/// The bloc that manages the state of the UI when the user is at a stop
class AtStopBloc extends Bloc<AtStopEvent, AtStopState> {
  /// The url of the server
  final String serverUrl = "https://hackathon-server.osc-fr1.scalingo.io/";

  AtStopBloc({
    required String stopName,
    required Pokemon wildPokemon,
  }) : super(AtStopInitialState(
          stopName: stopName,
          wildPokemon: wildPokemon,
        )) {
    // handle the event when the user wants to choose a pokemon
    // to fight the wild pokemon
    on<ChoosePokemon>((event, emit) {
      emit(ChoosingPokemon(
        stopName: state.stopName,
        wildPokemon: state.wildPokemon,
      ));
    });

    // handle the event when the user leaves or arrives at a stop
    on<GoToAtStopBlocInitial>((event, emit) {
      emit(AtStopInitialState(
        stopName: event.stopName,
        wildPokemon: event.wildPokemon,
      ));
    });

    // handle the event when the user wants to fight the wild pokemon
    // after choosing a pokemon
    on<PokemonChosen>((event, emit) async {
      Map<String, dynamic> body = {
        'owned_pokemon': event.pokemon.toMap(),
        'wild_pokemon': wildPokemon.toMap(),
      };

      // send the request to the server
      String encodedBody = jsonEncode(body);
      http.Response res = await http.post(
        Uri.parse('$serverUrl/fight'),
        headers: {
          "Content-Type": "application/json",
        },
        body: encodedBody,
      );
      // parse the response
      Map<String, dynamic> json = jsonDecode(res.body);
      if (kDebugMode) {
        print(json);
      }

      bool winnerBool = json["final_state"] == "you win";
      event.pokemon.xp = json["new_xp"];
      event.pokemon.xp = json["new_lvl"];

      // create the updated pokemon (the one that the user chose)
      Pokemon updatedPokemon = Pokemon.withXp(
        level: json["new_lvl"],
        name: event.pokemon.name,
        pictureUrl: event.pokemon.pictureUrl,
        xp: json["new_xp"],
        pokedexId: event.pokemon.pokedexId,
      );
      // List<Pokemon> newPokelist = event.pokelist.map<Pokemon>((e) {
      //   if (e.name == event.pokemon.name) {
      //     return event.pokemon;
      //   } else {
      //     return e;
      //   }
      // }).toList();

      // emit the new state that tell the UI that the fight is finished
      // with the winner and the xp won
      emit(FightFinished(
        stopName: state.stopName,
        wildPokemon: state.wildPokemon,
        chosenPokemon: updatedPokemon,
        winner: winnerBool,
        xpWon: json["xp_earned"],
      ));
    });
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';
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
      print("event OnChoose received");
      http.Response res = await http.get(Uri.parse(
          '$serverUrl/fight/${event.pokemon.name}/${event.pokemon.level}/${state.wildPokemon.name}/${state.wildPokemon.level}'));
      // parse this json
      Map<String, dynamic> json = jsonDecode(res.body);
      bool winnerBool = json["final_state"] == "you win";
      print(winnerBool);
      emit(FightFinished(
          pokelist: state.pokelist,
          stopName: state.stopName,
          wildPokemon: state.wildPokemon,
          chosenPokemon: event.pokemon,
          winner: winnerBool));
    });
  }
}

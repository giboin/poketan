import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:http/http.dart' as http;

part 'at_stop_event.dart';
part 'at_stop_state.dart';

class AtStopBloc extends Bloc<AtStopEvent, AtStopState> {
  final String serverUrl = "https://hackathon-server.osc-fr1.scalingo.io/";

  AtStopBloc()
      : super(AtStopInitialState(
            stopName: "Chantrerie - Grandes Ecoles",
            wildPokemon: Pokemon(
                name: "Ecremeuh",
                level: 20,
                pictureUrl:
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/241.png"),
            pokelist: [
              Pokemon(
                  name: "Salamouche",
                  level: 2,
                  pictureUrl:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
              Pokemon(
                  name: "Bulbazar",
                  level: 50,
                  pictureUrl:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
              Pokemon(
                  name: "Carapute",
                  level: 37,
                  pictureUrl:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
              Pokemon(
                  name: "Doudoudou",
                  level: 5,
                  pictureUrl:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png"),
              Pokemon(
                  name: "Sablaire",
                  level: 31,
                  pictureUrl:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/27.png"),
              Pokemon(
                  name: "Ratatrouille",
                  level: 22,
                  pictureUrl:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/19.png"),
            ])) {
    on<ChoosePokemon>((event, emit) async {
      http.Response res = await http.get(Uri.parse(
          '$serverUrl/fight/${event.pokemon.name}/${event.pokemon.level}/${state.wildPokemon.name}/${state.wildPokemon.level}'));
      // parse this json
      Map<String, dynamic> json = jsonDecode(res.body);
      bool winnerBool = json["final_state"] == "you win";
      emit(FightFinished(
          pokelist: state.pokelist,
          stopName: state.stopName,
          wildPokemon: state.wildPokemon,
          chosenPokemon: event.pokemon,
          winner: winnerBool));
    });
  }
}

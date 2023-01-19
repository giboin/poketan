import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon_adapter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

/// The bloc that manages the owned pokemons
/// And the user's pokemon team
/// It uses the HydratedBloc package to save the state of the bloc
/// when the app is closed
class OwnedPokemonsBloc
    extends HydratedBloc<OwnedPokemonsEvent, OwnedPokemonsState>
    with EquatableMixin {
  OwnedPokemonsBloc()
      : super(
          const OwnedPokemonsChooseStarter(),
        ) {
    // handle the event PokemonChanged when a pokemon is updated
    // (for example when it receives exp)
    // It updates the pokemon in the list of owned pokemons
    // It emits the state PokemonUpdated
    on<PokemonChanged>((event, emit) {
      if (kDebugMode) {
        print('on PokemonChanged');
      }

      // get the old list of owned pokemons
      List<Pokemon> pokeList =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];

      // update the pokemon in the list
      List<Pokemon> newPokelist = pokeList.map<Pokemon>((e) {
        if (e.pokedexId == event.pokemon.pokedexId) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();

      // get the old list of pokemons in the team
      List<Pokemon> pokeTeam =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeTeam : [];

      // update the pokemon in the team
      List<Pokemon> newPoketeam = pokeTeam.map<Pokemon>((e) {
        if (e.pokedexId == event.pokemon.pokedexId) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();

      // emit the new state
      emit(PokemonUpdated(pokeList: newPokelist, pokeTeam: newPoketeam));
    });

    // handle the event NewPokemon when a new pokemon is captured
    // It adds the pokemon to the list of owned pokemons
    // It emits the state PokemonUpdated
    on<NewPokemon>((event, emit) {
      if (kDebugMode) {
        print('on NewPokemon');
      }
      // get the old list of owned pokemons
      List<Pokemon> pokeList =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];

      // get the old list of pokemons in the team
      List<Pokemon> pokeTeam =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeTeam : [];

      // add the new pokemon to the list
      List<int> pokedexIds = pokeList.map<int>((e) => e.pokedexId).toList();
      if (!pokedexIds.contains(event.pokemon.pokedexId)) {
        pokeList.add(event.pokemon);
      }

      // emit the new state
      emit(PokemonUpdated(
          pokeList: List.from(pokeList), pokeTeam: List.from(pokeTeam)));
    });

    // handle the event NewTeam when the user changes his team
    on<NewTeam>((event, emit) {
      if (kDebugMode) {
        print('on NewTeam');
      }

      // get the old list of owned pokemons
      List<Pokemon> pokeList =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];
      emit(PokemonUpdated(
        pokeList: List.from(pokeList),
        pokeTeam: List.from(event.newTeam),
      ));
    });
  }

  /// This method is called when the app is opened
  /// It loads the state of the bloc from a json file
  @override
  OwnedPokemonsState? fromJson(Map<String, dynamic> json) {
    // get the list of owned pokemons and the team from the json file
    final List<dynamic> jsonPokelist = json['pokelist'] as List<dynamic>;
    final List<dynamic> jsonPoketeam = json['poketeam'] as List<dynamic>;

    // build the state of the bloc from the json file
    PokemonUpdated state = PokemonUpdated(
      pokeList:
          jsonPokelist.map((p) => PokemonAdapter.fromJson(json: p)).toList(),
      pokeTeam:
          jsonPoketeam.map((p) => PokemonAdapter.fromJson(json: p)).toList(),
    );
    return state;
  }

  /// This method is called when the state of the bloc is updated
  /// It loads the state of the bloc from the json file
  @override
  Map<String, dynamic>? toJson(OwnedPokemonsState state) {
    // if the state is PokemonUpdated, save the list of owned pokemons
    if (state is PokemonUpdated) {
      Map<String, dynamic> json = {
        'pokelist': state.pokeList.map((p) => p.toMap()).toList(),
        'poketeam': state.pokeTeam.map((p) => p.toMap()).toList(),
      };
      return json;
      // if not, don't save anything
    } else {
      return null;
    }
  }

  @override
  List<Object> get props => [];
}

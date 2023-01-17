import 'package:equatable/equatable.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon_adapter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../pokemon_at_stop/domain/pokemon.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

class OwnedPokemonsBloc
    extends HydratedBloc<OwnedPokemonsEvent, OwnedPokemonsState> {
  OwnedPokemonsBloc()
      : super(
          OwnedPokemonsInitial(pokeList: List.empty(), pokeTeam: List.empty()),
        ) {
    on<PokemonChanged>((event, emit) {
      List<Pokemon> newPokelist = state.pokeList.map<Pokemon>((e) {
        if (e.pokedexId == event.pokemon.pokedexId) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();

      List<Pokemon> newPoketeam = state.pokeTeam.map<Pokemon>((e) {
        if (e.pokedexId == event.pokemon.pokedexId) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();

      emit(PokemonUpdated(pokeList: newPokelist, pokeTeam: newPoketeam));
    });

    on<NewPokemon>((event, emit) {
      List<Pokemon> newPokelist = List.from(state.pokeList);
      List<int> pokedexIds =
          state.pokeList.map<int>((e) => e.pokedexId).toList();
      if (!pokedexIds.contains(event.pokemon.pokedexId)) {
        newPokelist.add(event.pokemon);
        //TODO c'est ça qui bug
      }
      emit(PokemonUpdated(
          pokeList: newPokelist, pokeTeam: List.from(state.pokeTeam)));
    });

    on<NewTeam>((event, emit) {
      emit(PokemonUpdated(
        pokeList: List.from(state.pokeList),
        pokeTeam: event.newTeam,
      ));
    });
  }

  @override
  OwnedPokemonsState? fromJson(Map<String, dynamic> json) {
    print('hello from Fromjson\n$json');
    return OwnedPokemonsInitial(
      pokeList: (json['pokelist'] as List<Map<String, dynamic>>)
          .map((p) => PokemonAdapter.fromJson(json: p))
          .toList(),
      pokeTeam: (json['poketeam'] as List<Map<String, dynamic>>)
          .map((p) => PokemonAdapter.fromJson(json: p))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(OwnedPokemonsState state) {
    print('hello from toJson\n${state.pokeList}\n${state.pokeTeam}');
    return {
      'pokelist': state.pokeList.map((p) => p.toJson()).toList(),
      'poketeam': state.pokeTeam.map((p) => p.toJson()).toList(),
    };
  }
}

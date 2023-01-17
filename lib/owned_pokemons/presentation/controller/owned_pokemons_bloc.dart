import 'package:equatable/equatable.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon_adapter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

class OwnedPokemonsBloc
    extends HydratedBloc<OwnedPokemonsEvent, OwnedPokemonsState>
    with EquatableMixin {
  OwnedPokemonsBloc()
      : super(
          const OwnedPokemonsChooseStarter(),
        ) {
    print(state.runtimeType);
    on<PokemonChanged>((event, emit) {
      print('on PokemonChanged');

      List<Pokemon> pokeList =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];

      List<Pokemon> newPokelist = pokeList.map<Pokemon>((e) {
        if (e.pokedexId == event.pokemon.pokedexId) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();

      List<Pokemon> pokeTeam =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];

      List<Pokemon> newPoketeam = pokeTeam.map<Pokemon>((e) {
        if (e.pokedexId == event.pokemon.pokedexId) {
          return event.pokemon;
        } else {
          return e;
        }
      }).toList();

      emit(PokemonUpdated(pokeList: newPokelist, pokeTeam: newPoketeam));
    });

    on<NewPokemon>((event, emit) {
      print('on NewPokemon');
      List<Pokemon> pokeList =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];
      List<Pokemon> pokeTeam =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeTeam : [];

      List<int> pokedexIds = pokeList.map<int>((e) => e.pokedexId).toList();
      if (!pokedexIds.contains(event.pokemon.pokedexId)) {
        pokeList.add(event.pokemon);
      }
      emit(PokemonUpdated(pokeList: pokeList, pokeTeam: List.from(pokeTeam)));
    });

    on<NewTeam>((event, emit) {
      print('on NewTeam');
      List<Pokemon> pokeList =
          (state is PokemonUpdated) ? (state as PokemonUpdated).pokeList : [];
      emit(PokemonUpdated(
        pokeList: List.from(pokeList),
        pokeTeam: event.newTeam,
      ));
    });
  }

  @override
  OwnedPokemonsState? fromJson(Map<String, dynamic> json) {
    print('hello from Fromjson\n$json');
    return PokemonUpdated(
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
    if (state is PokemonUpdated) {
      print(
          'hello from toJson\npokelist : ${state.pokeList}\npoketeam : ${state.pokeTeam}');

      Map<String, dynamic> json = {
        'pokelist': state.pokeList.map((p) => p.toJson()).toList(),
        'poketeam': state.pokeTeam.map((p) => p.toJson()).toList(),
      };

      print('json : $json');
      return json;
    }
  }

  @override
  List<Object> get props => [];
}

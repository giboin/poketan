import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../pokemon_at_stop/domain/pokemon.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

class OwnedPokemonsBloc
    extends HydratedBloc<OwnedPokemonsEvent, OwnedPokemonsState> {
  OwnedPokemonsBloc()
      : super(const OwnedPokemonsInitial(pokeList: [], pokeTeam: [])) {
    on<OwnedPokemonsEvent>((event, emit) {
      // TODO: implement event handler
    });
 
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
      emit(PokemonUpdated(pokeList: newPokelist, pokeTeam: state.pokeTeam));
    });

    on<NewTeam>((event, emit) {
      emit(PokemonUpdated(pokeList: state.pokeList, pokeTeam: event.newTeam));
    });
  }

   

  @override
  OwnedPokemonsState? fromJson(Map<String, dynamic> json) {
    return OwnedPokemonsInitial(
        pokeList: json['pokelist'], pokeTeam: json['poketeam']);
  }

  @override
  Map<String, dynamic>? toJson(OwnedPokemonsState state) {
    state.pokeList.addAll([]);

    return {'pokelist': state.pokeList, 'poketeam': state.pokeTeam};
  }
}

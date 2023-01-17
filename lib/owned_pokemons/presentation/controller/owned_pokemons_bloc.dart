import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../pokemon_at_stop/domain/pokemon.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

class OwnedPokemonsBloc
    extends HydratedBloc<OwnedPokemonsEvent, OwnedPokemonsState> {
  OwnedPokemonsBloc()
      : super(OwnedPokemonsInitial(pokeList: [
          Pokemon(
              name: "Salamouche",
              level: 2,
              pokedexId: 4,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
          Pokemon(
              name: "Bulbazar",
              level: 50,
              pokedexId: 1,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
          Pokemon(
              name: "Carapute",
              level: 37,
              pokedexId: 7,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
          Pokemon(
              name: "Doudoudou",
              level: 5,
              pokedexId: 39,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png"),
          Pokemon(
              name: "Sablaire",
              level: 31,
              pokedexId: 27,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/27.png"),
          Pokemon(
              name: "Ratatrouille",
              level: 22,
              pokedexId: 19,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/19.png"),
          Pokemon(
              name: "Chenapan",
              level: 99,
              pokedexId: 10,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png"),
          Pokemon(
              name: "Ohlachance",
              level: 37,
              pokedexId: 113,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/113.png"),
          Pokemon(
              name: "Grosbazar",
              level: 12,
              pokedexId: 3,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"),
        ], pokeTeam: [
          Pokemon(
              name: "Doudoudou",
              level: 5,
              pokedexId: 39,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png"),
          Pokemon(
              name: "Sablaire",
              level: 31,
              pokedexId: 27,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/27.png"),
          Pokemon(
              name: "Ratatrouille",
              level: 22,
              pokedexId: 19,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/19.png"),
        ])) {
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
      List<Pokemon> newPokelist = state.pokeList;
      List<int> pokedexIds =
          state.pokeList.map<int>((e) => e.pokedexId).toList();
      if (!pokedexIds.contains(event.pokemon.pokedexId)) {
        newPokelist.add(event.pokemon);
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

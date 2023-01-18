part of 'owned_pokemons_bloc.dart';

abstract class OwnedPokemonsState extends Equatable {
  const OwnedPokemonsState();
}

class OwnedPokemonsChooseStarter extends OwnedPokemonsState {
  const OwnedPokemonsChooseStarter();

  @override
  List<Object?> get props => [];
}

class PokemonUpdated extends OwnedPokemonsState {
  final List<Pokemon> pokeList;
  final List<Pokemon> pokeTeam;

  const PokemonUpdated({
    required this.pokeList,
    required this.pokeTeam,
  });

  // TODO: PTDR
  @override
  List<Object> get props => [pokeList, pokeTeam, Random().nextInt(100000)];
}

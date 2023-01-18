part of 'owned_pokemons_bloc.dart';

abstract class OwnedPokemonsState extends Equatable {
  const OwnedPokemonsState();
}

/// The state that the bloc is in when it is first created
/// It should be used only once
class OwnedPokemonsChooseStarter extends OwnedPokemonsState {
  const OwnedPokemonsChooseStarter();

  @override
  List<Object?> get props => [];
}

/// The state that the bloc is in when it needs to display
/// the list of the owned pokemons and the team
class PokemonUpdated extends OwnedPokemonsState {
  // the list of the owned pokemons
  final List<Pokemon> pokeList;
  // the list of the pokemons in the team
  final List<Pokemon> pokeTeam;

  const PokemonUpdated({
    required this.pokeList,
    required this.pokeTeam,
  });

  // for pointer equality reasons, we need to add a random number
  // to the props list to make sure that the states emitted by the bloc
  // are different and the UI rebuilds accordingly
  @override
  List<Object> get props => [pokeList, pokeTeam, Random().nextInt(100000)];
}

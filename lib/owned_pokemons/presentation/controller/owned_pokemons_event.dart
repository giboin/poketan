part of 'owned_pokemons_bloc.dart';

/// The events that can be sent to the bloc
abstract class OwnedPokemonsEvent extends Equatable {
  const OwnedPokemonsEvent();

  @override
  List<Object> get props => [];
}

/// The event that is sent when a pokemon is
/// changed (for example when it gains exp after a fight)
class PokemonChanged extends OwnedPokemonsEvent {
  /// The pokemon that has been changed
  final Pokemon pokemon;

  const PokemonChanged({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

/// The event that is sent when a pokemon is added
/// to the list of owned pokemons
class NewPokemon extends OwnedPokemonsEvent {
  /// The pokemon that has been added
  final Pokemon pokemon;

  const NewPokemon({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

/// The event that is sent when the user's pokemon
/// team is changed
class NewTeam extends OwnedPokemonsEvent {
  /// The new team
  final List<Pokemon> newTeam;

  const NewTeam({required this.newTeam});

  @override
  List<Object> get props => [newTeam];
}

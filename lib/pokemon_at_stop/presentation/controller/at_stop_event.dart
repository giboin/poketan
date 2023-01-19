part of 'at_stop_bloc.dart';

/// The events that the AtStopBloc can receive
abstract class AtStopEvent extends Equatable {
  /// The list of the pokemons of the user
  final List<Pokemon> pokelist;

  const AtStopEvent({
    required this.pokelist,
  });

  @override
  List<Object> get props => [pokelist];
}

/// The event that the AtStopBloc receives when the user
/// chose a pokemon to fight the wild pokemon
class PokemonChosen extends AtStopEvent {
  /// The pokemon that the user chose
  final Pokemon pokemon;

  const PokemonChosen({
    required this.pokemon,
    required super.pokelist,
  });

  @override
  List<Object> get props => [pokemon, pokelist];
}

/// The event that the AtStopBloc receives when the user
/// wants to fight the wild pokemon
class ChoosePokemon extends AtStopEvent {
  const ChoosePokemon({
    required super.pokelist,
  });
}

/// The event that the AtStopBloc receives when the user
/// leaves or arrives at a stop
class GoToAtStopBlocInitial extends AtStopEvent {
  /// The wild pokemon that the user can fight
  final Pokemon wildPokemon;

  /// The name of the stop
  final String stopName;

  const GoToAtStopBlocInitial({
    required super.pokelist,
    required this.wildPokemon,
    required this.stopName,
  });

  @override
  List<Object> get props => [wildPokemon, stopName, pokelist];
}

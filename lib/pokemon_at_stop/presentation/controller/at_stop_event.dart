part of 'at_stop_bloc.dart';

abstract class AtStopEvent extends Equatable {
  final List<Pokemon> pokelist;

  const AtStopEvent({
    required this.pokelist,
  });

  @override
  List<Object> get props => [pokelist];
}

class PokemonChosen extends AtStopEvent {
  final Pokemon pokemon;

  const PokemonChosen({
    required this.pokemon,
    required super.pokelist,
  });

  @override
  List<Object> get props => [pokemon, pokelist];
}

class ChoosePokemon extends AtStopEvent {
  const ChoosePokemon({
    required super.pokelist,
  });
}

class GoToAtStopBlocInitial extends AtStopEvent {
  final Pokemon wildPokemon;
  final String stopName;

  const GoToAtStopBlocInitial({
    required super.pokelist,
    required this.wildPokemon,
    required this.stopName,
  });

  @override
  List<Object> get props => [wildPokemon, stopName, pokelist];
}

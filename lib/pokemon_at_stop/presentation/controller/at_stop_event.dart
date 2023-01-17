part of 'at_stop_bloc.dart';

abstract class AtStopEvent extends Equatable {
  const AtStopEvent();

  @override
  List<Object> get props => [];
}

class PokemonChosen extends AtStopEvent {
  final Pokemon pokemon;

  const PokemonChosen({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

class ChoosePokemon extends AtStopEvent {
  const ChoosePokemon();
}

class GoToAtStopBlocInitial extends AtStopEvent {
  final Pokemon wildPokemon;
  final String stopName;

  const GoToAtStopBlocInitial(
      {required this.wildPokemon,
      required this.stopName});
}

part of 'at_stop_bloc.dart';

abstract class AtStopState extends Equatable {
  final String stopName;
  final Pokemon wildPokemon;

  const AtStopState(
      {required this.stopName,
      required this.wildPokemon});

  @override
  List<Object> get props => [stopName, wildPokemon];
}

class AtStopInitialState extends AtStopState {
  const AtStopInitialState(
      {required super.stopName,
      required super.wildPokemon});
}

class ChoosingPokemon extends AtStopState {
  const ChoosingPokemon(
      {required super.stopName,
      required super.wildPokemon});
}

class FightFinished extends AtStopState {
  final bool winner;
  final Pokemon chosenPokemon;
  final int xpWon;

  const FightFinished(
      {required super.stopName,
      required super.wildPokemon,
      required this.chosenPokemon,
      required this.winner,
      required this.xpWon});

  @override
  List<Object> get props =>
      [stopName, wildPokemon, chosenPokemon, winner, xpWon];
}

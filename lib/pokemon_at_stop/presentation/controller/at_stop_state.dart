part of 'at_stop_bloc.dart';

abstract class AtStopState extends Equatable {
  final List<Pokemon> pokelist;
  final String stopName;
  final Pokemon wildPokemon;

  const AtStopState(
      {required this.pokelist,
      required this.stopName,
      required this.wildPokemon});

  @override
  List<Object> get props => [pokelist, stopName, wildPokemon];
}

class AtStopInitialState extends AtStopState {
  const AtStopInitialState(
      {required super.pokelist,
      required super.stopName,
      required super.wildPokemon});
}

class FightFinished extends AtStopState {
  final String winner;

  const FightFinished(
      {required super.pokelist,
      required super.stopName,
      required super.wildPokemon,
      required this.winner});

  @override
  List<Object> get props => [pokelist, stopName, wildPokemon, winner];
}

part of 'at_stop_bloc.dart';

/// The states that the AtStopBloc can be in
abstract class AtStopState extends Equatable {
  /// The name of the stop
  final String stopName;

  /// The wild pokemon that the user can fight
  final Pokemon wildPokemon;

  const AtStopState({
    required this.stopName,
    required this.wildPokemon,
  });

  @override
  List<Object> get props => [stopName, wildPokemon];
}

/// The initial state of the AtStopBloc
/// with the name of the stop and the wild pokemon
class AtStopInitialState extends AtStopState {
  const AtStopInitialState({
    required super.stopName,
    required super.wildPokemon,
  });
}

/// The state that the AtStopBloc is in when
/// the user is choosing a pokemon to fight the wild pokemon
class ChoosingPokemon extends AtStopState {
  const ChoosingPokemon({
    required super.stopName,
    required super.wildPokemon,
  });
}

/// The state that the AtStopBloc is in when
/// the user is has finished the fight
class FightFinished extends AtStopState {
  /// A boolean that indicates if the user won the fight
  final bool winner;

  /// The pokemon that the user chose
  final Pokemon chosenPokemon;

  /// The xp that the user won
  final int xpWon;

  const FightFinished({
    required super.stopName,
    required super.wildPokemon,
    required this.chosenPokemon,
    required this.winner,
    required this.xpWon,
  });

  @override
  List<Object> get props =>
      [stopName, wildPokemon, chosenPokemon, winner, xpWon];
}

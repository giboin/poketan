part of 'at_stop_bloc.dart';

abstract class AtStopState extends Equatable {
  const AtStopState();

  @override
  List<Object> get props => [];
}

class AtStopInitialState extends AtStopState {
  final List<Pokemon> pokelist;
  final String stopName;
  final Pokemon wildPokemon;

  const AtStopInitialState({required this.pokelist, required this.stopName, required this.wildPokemon});
}

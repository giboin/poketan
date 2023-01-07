part of 'at_stop_bloc.dart';

abstract class AtStopEvent extends Equatable {
  const AtStopEvent();

  @override
  List<Object> get props => [];
}

class ChoosePokemon extends AtStopEvent {
  final Pokemon pokemon;

  const ChoosePokemon({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

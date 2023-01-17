part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FindPokemon extends HomeEvent {}

class SendLocalisation extends HomeEvent {}

class GoToHomeBlocInitial extends HomeEvent {}

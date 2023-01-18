part of 'home_bloc.dart';

/// The events that can be sent to the bloc
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// The event that is sent when the user wants to find a pokemon
class FindPokemon extends HomeEvent {}

/// The event that is sent when the bloc
/// needs to send the localisation of the user to the server
class SendLocalisation extends HomeEvent {}

/// The event that is sent when the user wants to go to the home page
/// or when the bloc needs to go to the home page (for example when
/// the user finds a pokemon)
class GoToHomeBlocInitial extends HomeEvent {}

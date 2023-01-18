part of 'home_bloc.dart';

/// The states that the bloc can be in
abstract class HomeState extends Equatable {
  /// The response of the server when the user sends its localisation
  final Map<String, dynamic>? responseJson;

  /// The constructor of the state
  const HomeState({
    this.responseJson,
  });

  @override
  List<Object?> get props => [responseJson];
}

/// The state that the bloc is in when
/// it needs to display the home page
class HomeInitial extends HomeState {
  /// The boolean that indicates if the user is near a stop
  final bool nearAStop;

  /// The constructor of the state
  const HomeInitial({
    required this.nearAStop,
    super.responseJson,
  });

  @override
  List<Object?> get props => [
        responseJson,
        nearAStop,
      ];
}

/// The state that the bloc is in when
/// it needs to display the fight page
class HomeFoundPokemon extends HomeState {
  const HomeFoundPokemon({
    super.responseJson,
  });
}

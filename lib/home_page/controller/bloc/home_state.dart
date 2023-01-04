part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final Map<String, dynamic>? responseJson;

  const HomeState({
    this.responseJson,
  });

  @override
  List<Object> get props => [responseJson ?? {}];
}

class HomeInitial extends HomeState {
  final bool nearAStop;

  const HomeInitial({
    required this.nearAStop,
    super.responseJson,
  });

  @override
  List<Object> get props => [
        responseJson ?? {},
        nearAStop,
      ];
}

class HomeFoundPokemon extends HomeState {
  const HomeFoundPokemon({
    super.responseJson,
  });
}

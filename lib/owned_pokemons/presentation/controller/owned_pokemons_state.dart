part of 'owned_pokemons_bloc.dart';

abstract class OwnedPokemonsState extends Equatable {
  final List<Pokemon> pokeTeam;
  final List<Pokemon> pokeList;

  const OwnedPokemonsState({required this.pokeList, required this.pokeTeam});

  @override
  List<Object> get props => [pokeList, pokeTeam];
}

class OwnedPokemonsInitial extends OwnedPokemonsState {
  const OwnedPokemonsInitial(
      {required super.pokeList, required super.pokeTeam});
}

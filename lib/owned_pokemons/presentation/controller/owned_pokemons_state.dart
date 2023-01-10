part of 'owned_pokemons_bloc.dart';

abstract class OwnedPokemonsState extends Equatable {
  const OwnedPokemonsState();
  
  @override
  List<Object> get props => [];
}

class OwnedPokemonsInitial extends OwnedPokemonsState {}

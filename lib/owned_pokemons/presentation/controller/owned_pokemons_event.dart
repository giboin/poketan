part of 'owned_pokemons_bloc.dart';

abstract class OwnedPokemonsEvent extends Equatable {
  const OwnedPokemonsEvent();

  @override
  List<Object> get props => [];
}

class PokemonChanged extends OwnedPokemonsEvent {
  final Pokemon pokemon;

  const PokemonChanged({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

class NewPokemon extends OwnedPokemonsEvent {
  final Pokemon pokemon;

  const NewPokemon({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

class NewTeam extends OwnedPokemonsEvent {
  final List<Pokemon> newTeam;
  const NewTeam({required this.newTeam});

  @override
  List<Object> get props => [newTeam];
}

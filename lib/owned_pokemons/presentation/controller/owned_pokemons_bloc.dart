import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

class OwnedPokemonsBloc extends Bloc<OwnedPokemonsEvent, OwnedPokemonsState> {
  OwnedPokemonsBloc() : super(OwnedPokemonsInitial()) {
    on<OwnedPokemonsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owned_pokemons_event.dart';
part 'owned_pokemons_state.dart';

class OwnedPokemonsBloc extends Bloc<OwnedPokemonsEvent, OwnedPokemonsState> {
  OwnedPokemonsBloc() : super(OwnedPokemonsInitial()) {
    on<OwnedPokemonsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

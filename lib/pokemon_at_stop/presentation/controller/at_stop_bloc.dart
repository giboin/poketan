import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

part 'at_stop_event.dart';
part 'at_stop_state.dart';

class AtStopBloc extends Bloc<AtStopEvent, AtStopState> {
  AtStopBloc()
      : super(AtStopInitialState(stopName: "", pokelist: [
          Pokemon(
              name: "Salamouche",
              level: 2,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
          Pokemon(
              name: "Bulbazar",
              level: 50,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
          Pokemon(
              name: "Carapute",
              level: 37,
              pictureUrl:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
        ]));
}

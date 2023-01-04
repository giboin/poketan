import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String serverUrl = "https://hackathon-server.osc-fr1.scalingo.io/";
  late StreamSubscription localisationLoop;

  HomeBloc()
      : super(const HomeInitial(
          nearAStop: false,
        )) {
    on<SendLocalisation>((event, emit) async {
      // get the user localisation
      double lat = 47.22024715;
      double long = -1.60339908;

      // send the localisation of the user to the server
      Response res =
          await http.get(Uri.parse('$serverUrl/localisation/$lat/$long'));

      // parse this json
      Map<String, dynamic> json = jsonDecode(res.body);
      emit(HomeInitial(nearAStop: true, responseJson: json));
    });

    on<FindPokemon>((event, emit) {
      // if (state.responseJson == null) {}
      // go to the fighting screen
      emit(HomeFoundPokemon(responseJson: state.responseJson!));
    });

    localisationLoop =
        Stream.periodic(const Duration(seconds: 3)).listen((event) {
      add(SendLocalisation());
    });
  }

  @override
  Future<void> close() {
    localisationLoop.cancel();
    return super.close();
  }
}

/*      Pokemon wildPokemon = Pokemon.from_json(json['pokemon_data']);
      String stopName = json['stop_name'];*/

import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';

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
      // source : https://www.fluttercampus.com/guide/212/get-gps-location/
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
        } else if (permission == LocationPermission.deniedForever) {
          if (kDebugMode) {
            print("'Location permissions are permanently denied");
          }
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      if (kDebugMode) {
        print(position.longitude); //Output: -1.521223
        print(position.latitude); //Output: 47.2828964
      }

      double long = position.longitude;
      double lat = position.latitude;

      // send the localisation of the user to the server
      Response res =
          await http.get(Uri.parse('$serverUrl/localisation/$lat/$long'));
      // parse this json
      Map<String, dynamic> json = jsonDecode(res.body);
      emit(HomeInitial(
          nearAStop: json["stop_name"] != "too_far", responseJson: json));
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

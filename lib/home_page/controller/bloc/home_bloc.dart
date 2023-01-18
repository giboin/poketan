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

/// The bloc that manages the home page
/// It sends the localisation of the user to the server
/// and receives the pokemon that is near the user
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String serverUrl = "https://hackathon-server.osc-fr1.scalingo.io/";
  late StreamSubscription localisationLoop;

  /// The constructor of the bloc
  /// It initializes the state of the bloc
  /// and the handler of the events
  /// It also sends the localisation of the user to the server
  /// every 10 seconds. (that might be changed later)
  HomeBloc()
      : super(const HomeInitial(
          nearAStop: false,
        )) {
    // handle the events GoToHomeBlocInitial
    // It sets the state of the bloc to HomeInitial
    on<GoToHomeBlocInitial>((event, emit) {
      emit(const HomeInitial(nearAStop: false));
    });

    // handle the event SendLocalisation
    // It sends the localisation of the user to the server
    // and parses the response
    // It then sets the state of the bloc to HomeInitial
    on<SendLocalisation>((event, emit) async {
      // get the user localisation
      // source : https://www.fluttercampus.com/guide/212/get-gps-location/
      LocationPermission permission = await Geolocator.checkPermission();

      // if the permission is denied, ask for it
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        // if the permission is still denied, print an error message
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
          // if the permission is denied forever, print an error message
        } else if (permission == LocationPermission.deniedForever) {
          if (kDebugMode) {
            print("'Location permissions are permanently denied");
          }
        }
      }

      // get the localisation of the user
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

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

    // handle the event FindPokemon
    // It sets the state of the bloc to HomeFoundPokemon
    // HomeFoundPokemon is the state that tells the view
    // to go to the fighting screen
    on<FindPokemon>((event, emit) {
      emit(HomeFoundPokemon(responseJson: state.responseJson!));
    });

    // create a stream that sends the localisation of the user
    // to the server every 10 seconds
    localisationLoop = Stream.periodic(const Duration(seconds: 10)).listen((_) {
      add(SendLocalisation());
    });

    // send the localisation of the user to the server
    // when the bloc is created
    add(SendLocalisation());
  }

  /// This method is called when the bloc is closed
  /// It cancels the stream that sends the localisation of the user
  /// to prevent memory leaks
  @override
  Future<void> close() {
    localisationLoop.cancel();
    return super.close();
  }
}

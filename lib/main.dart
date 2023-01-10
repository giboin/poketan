import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/pokemon_at_stop/domain/adapters/stop.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hackathon/pokemon_at_stop/presentation/at_stop_view.dart';
import 'package:http/http.dart';

import 'owned_pokemons/presentation/view/owned_pokemons_view.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String temporaryPath = (await getTemporaryDirectory()).absolute.path;
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: Directory("${temporaryPath}/hydrated_bloc_storage"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: ((context) => HomeBloc())),
          BlocProvider<AtStopBloc>(create: (context) {
            Map<String, dynamic> json =
                context.read<HomeBloc>().state.responseJson ??
                    {
                      "pokemon_data": {
                        'name': 'pokemon_name',
                        'lvl': 0,
                        'sprite_url':
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png'
                      },
                      'stop_name': 'tan_stop'
                    };
            return AtStopBloc(
                stopName: json["stop_name"].toString(),
                wildPokemon: Pokemon(
                    name: json["pokemon_data"]["name"].toString(),
                    level: json["pokemon_data"]["lvl"],
                    pictureUrl: json["pokemon_data"]["sprite_url"].toString()));
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => const HomeView(),
            'pokemon_at_stop': (context) => const PokemonsAtStopView(),
            'owned_pokemons': (context) => OwnedPokemons(),
          },
        ));
  }
}

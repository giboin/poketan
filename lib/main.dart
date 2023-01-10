import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hackathon/pokemon_at_stop/presentation/at_stop_view.dart';

import 'owned_pokemons/presentation/owned_pokemons_view.dart';

void main() {
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
          BlocProvider<AtStopBloc>(
              lazy: false, create: (context) => AtStopBloc()),
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
            'owned_pokemons' :(context) => OwnedPokemons(),
          },
        ));
  }
}

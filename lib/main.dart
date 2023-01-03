import 'package:flutter/material.dart';
import 'package:hackathon/pokemon_at_stop/domain/Pokemon.dart';
import 'package:hackathon/screen/pokeballScreen.dart';
import 'package:hackathon/screen/pokemonRewarded.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonRewardedScreen(pokemon: Pokemon("Milobellus", 46, pictureUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/350.png"),),
    );
  }
}

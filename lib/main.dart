import 'package:flutter/material.dart';
import 'package:hackathon/pokeballScreen.dart';
import 'package:hackathon/pokemon_at_stop/presentation/pokemonsAtStop.dart';

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
      home: PokemonsAtStopScreen(stopId: "",),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/Pokemon.dart';

class PokemonsAtStopScreen extends StatefulWidget {
  final String stopId;

  const PokemonsAtStopScreen({Key? key, required this.stopId}) : super(key: key);

  @override
  State<PokemonsAtStopScreen> createState() => _PokemonsAtStopScreenState();
}

class _PokemonsAtStopScreenState extends State<PokemonsAtStopScreen> {

  List<Pokemon> pokelist=[Pokemon("Salamouche", 2), Pokemon("Bulbazar", 50), Pokemon("Carapute", 37)];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Pokemon'),centerTitle: true,),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  itemCount: pokelist.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                          title:Text("${pokelist[index].name}, level ${pokelist[index].level}")
                      ),
                    );
                  }
              )
          ),
        )
    );
  }
}

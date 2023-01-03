import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/widgets/appBar.dart';

class PokemonsAtStopScreen extends StatefulWidget {
  final String stopId;

  const PokemonsAtStopScreen({Key? key, required this.stopId}) : super(key: key);

  @override
  State<PokemonsAtStopScreen> createState() => _PokemonsAtStopScreenState();
}

class _PokemonsAtStopScreenState extends State<PokemonsAtStopScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text('Pokemon'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container()
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:hackathon/widgets/pokeball_widget.dart';

class PokeballScreen extends StatefulWidget {
  const PokeballScreen({Key? key}) : super(key: key);

  @override
  State<PokeballScreen> createState() => _PokeballScreenState();
}

class _PokeballScreenState extends State<PokeballScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon'),
          centerTitle: true,
        ),
        body: const PokeballWidget(
          isColored: false,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/screen/pokeball_screen.dart';

class PokemonRewardedScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonRewardedScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  State<PokemonRewardedScreen> createState() => _PokemonRewardedScreenState();
}

class _PokemonRewardedScreenState extends State<PokemonRewardedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon'),
          centerTitle: true,
          leading: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PokeballScreen()),
                );
              },
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              )),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "You have win",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.network(
                widget.pokemon.pictureUrl,
                scale: 0.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${widget.pokemon.name} at Level ${widget.pokemon.level}',
                style:
                    const TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      ),
    );
  }
}

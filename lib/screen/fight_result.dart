import 'package:flutter/material.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class FightResultScreen extends StatefulWidget {
  final Pokemon pokemon;
  final String winnerText;

  const FightResultScreen(
      {Key? key, required this.pokemon, required this.winnerText})
      : super(key: key);

  @override
  State<FightResultScreen> createState() => _FightResultScreenState();
}

class _FightResultScreenState extends State<FightResultScreen> {
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
                  MaterialPageRoute(builder: (context) => const HomeView()),
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
              Text(widget.winnerText),
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

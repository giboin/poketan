import 'package:flutter/material.dart';
import 'package:hackathon/home_page/controller/view/home_view.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class FightResultScreen extends StatefulWidget {
  final Pokemon pokemon;
  final bool hasWin;

  const FightResultScreen(
      {Key? key, required this.pokemon, required this.hasWin})
      : super(key: key);

  @override
  State<FightResultScreen> createState() => _FightResultScreenState();
}

class _FightResultScreenState extends State<FightResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.hasWin ? Colors.green : Colors.red,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView())),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 55.0,
              ),
              Text(
                widget.hasWin ? 'You won' : 'You lose',
                style: const TextStyle(
                    fontSize: 50.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Image.network(
                widget.pokemon.pictureUrl,
                scale: 0.3,
              ),
              Text(
                '${widget.pokemon.name} at level ${widget.pokemon.level}',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 250,
                margin: const EdgeInsets.only(top: 100.0),
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(backgroundColor: widget.hasWin? Colors.red : Colors.black, padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.keyboard_return_outlined, size: 30,),
                      SizedBox(width: 10.0),
                      Text('Refaire un combat', style: TextStyle(fontSize: 22.0),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

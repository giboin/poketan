import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';

class FightResultScreen extends StatelessWidget {
  final Pokemon pokemon;
  final bool hasWin;
  final int xpEarned;

  const FightResultScreen(
      {Key? key,
      required this.pokemon,
      required this.hasWin,
      required this.xpEarned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Pokemon> pokeList = context.read<OwnedPokemonsBloc>().state.pokeList;
    return SafeArea(
      child: Scaffold(
        backgroundColor: hasWin ? Colors.green : Colors.red,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        AtStopState state = context.read<AtStopBloc>().state;
                        context.read<AtStopBloc>().add(GoToAtStopBlocInitial(
                              pokelist: pokeList,
                              wildPokemon: state.wildPokemon,
                              stopName: state.stopName,
                            ));
                        context.read<HomeBloc>().add(GoToHomeBlocInitial());
                        // Navigator.pushNamed(context, '/');
                        Navigator.popUntil(context,
                            (route) => ModalRoute.withName('/')(route));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const HomeView()));
                      },
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
                hasWin ? 'You won' : 'You lose',
                style: const TextStyle(
                    fontSize: 50.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Image.network(
                pokemon.pictureUrl,
                scale: 0.3,
              ),
              Text(
                '$xpEarned xp earned',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${pokemon.name} at level ${pokemon.level}',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

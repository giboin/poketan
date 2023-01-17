import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/screen/fight_result.dart';
import 'package:hackathon/screen/pokemon_to_fight.dart';

import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';

class PokemonsAtStopView extends StatelessWidget {
  const PokemonsAtStopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AtStopBloc, AtStopState>(listener: (context, state) {
      if (state is AtStopInitialState) {}
      if (state is FightFinished) {
        context
            .read<OwnedPokemonsBloc>()
            .add(PokemonChanged(pokemon: state.chosenPokemon));
        if (state.winner) {
          context
              .read<OwnedPokemonsBloc>()
              .add(NewPokemon(pokemon: state.wildPokemon));
        }
      }
    }, builder: (context, state) {
      if (state is AtStopInitialState) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(20.0),
              child: AppBar(
                primary: false,
                title: Text(
                  state.stopName,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.green,
              )),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/arrêt_tram_nantes.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Stack(children: [
                    Opacity(
                        opacity: 0.6,
                        child: SvgPicture.asset('assets/pokeball-grisee.svg')),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Image.network(
                        state.wildPokemon.pictureUrl,
                        scale: 0.2,
                      ),
                    ),
                  ]),
                ),

                /*Expanded(
                  child: ListView.builder(
                      itemCount: state.pokelist.length,
                      itemBuilder: (context, index) {
                        Pokemon pokemon = state.pokelist[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                                "${pokemon.name}, niveau ${pokemon.level}"),
                            trailing: Image.network(pokemon.pictureUrl),
                            onTap: () {
                              context
                                  .read<AtStopBloc>()
                                  .add(ChoosePokemon(pokemon: pokemon));
                            },
                          ),
                        );
                      }),
                ),*/
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            height: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                 // context.read<AtStopBloc>().add(const ChoosePokemon());
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.bolt_sharp,
                  size: 35,
                ),
              ),
            ),
          ),
        );
      }
      if (state is FightFinished) {
        return WillPopScope(
          child: FightResultScreen(
              pokemon: state.chosenPokemon,
              hasWin: state.winner,
              xpEarned: state.xpWon),
          onWillPop: () async {
            context.read<HomeBloc>().add(GoToHomeBlocInitialState());
            Navigator.pushNamed(context, "/");
            return false;
          },
        );
      }
      if (state is ChoosingPokemon) {
        return WillPopScope(
          child: FightDialog(atStopState: state),
          onWillPop: () async {
            context.read<AtStopBloc>().add(const GoToInitialState());
            return false;
          },
        );
      } else {
        return const Text('this is not exactly the ideal state');
      }
    });
  }
}

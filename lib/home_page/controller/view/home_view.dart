import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hackathon/widgets/pokeball_widget.dart';

import '../../../pokemon_at_stop/domain/pokemon.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFoundPokemon) {
          Map<String, dynamic> json = state.responseJson ??
              {
                "pokemon_data": {
                  'name': 'pokemon_name',
                  'lvl': 0,
                  'sprite_url':
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png'
                },
                'stop_name': 'tan_stop'
              };
          Pokemon wildPokemon = Pokemon(
              name: json["pokemon_data"]["name"].toString(),
              level: json["pokemon_data"]["lvl"],
              pictureUrl: json["pokemon_data"]["sprite_url"].toString(),
              pokedexId: json["pokemon_data"]["pokedex_id"]);

          List<Pokemon> pokelist =
              context.read<OwnedPokemonsBloc>().state.pokeList;
          context.read<AtStopBloc>().add(GoToAtStopBlocInitial(
              pokelist: pokelist,
              wildPokemon: wildPokemon,
              stopName: json["stop_name"].toString()));
          Navigator.of(context).pushNamed('pokemon_at_stop');
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return Scaffold(
            floatingActionButton: SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: Image.asset("assets/backpack.png"),
                onPressed: () {
                  // TODO: Changer ça avec BLoC (add un event, push un state, push la navigationa avec le listener)
                  Navigator.of(context).pushNamed('owned_pokemons');
                },
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/nantes_map_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  if (state.nearAStop) {
                    Navigator.of(context).pushNamed('pokemon_at_stop');
                    //context.read<HomeBloc>().add(FindPokemon());
                  }
                },
                child: PokeballWidget(
                  isColored: state.nearAStop,
                ),
              ),
            ),
          );
        } else {
          // TODO: à la place de ça qui bloque l'appli, on devrait ajouter un event pour retourner sur l'état initial.
          return const Text("Loading");
        }
      },
    );
  }
}

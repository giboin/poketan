import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home_page/controller/bloc/home_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon_adapter.dart';
import 'package:hackathon/pokemon_at_stop/presentation/controller/at_stop_bloc.dart';
import 'package:hackathon/widgets/pokeball_widget.dart';

/// The view of the home page
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocConsumer is a widget that allows to listen to the state of the bloc
    // and to build the widget according to the state
    return BlocConsumer<HomeBloc, HomeState>(
      // The listener is called when the state changes
      // It is used to push a new view on the widget tree
      // It is called only when the state changes
      listener: (context, state) {
        // If the state is HomeInitial, tell the AtStopBloc to go to its initial state
        if (state is HomeInitial) {
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
          context.read<AtStopBloc>().add(GoToAtStopBlocInitial(
              pokelist: (state is PokemonUpdated)
                  ? (state as PokemonUpdated).pokeList
                  : [],
              wildPokemon: PokemonAdapter.fromJson(json: json["pokemon_data"]),
              stopName: json["stop_name"].toString()));
        }
      },
      // The builder method builds the widget according
      // to the state it is in
      builder: (context, state) {
        // If the state is HomeInitial (it should aways be), display the home page
        if (state is HomeInitial) {
          return Scaffold(
            // This floating action button is the backpack button
            floatingActionButton: SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: Image.asset("assets/backpack.png"),
                onPressed: () {
                  // TODO: Changer ça avec BLoC (add un event, push un state, push la navigation avec le listener)
                  // Push the owned pokemons page onto the widget tree
                  Navigator.of(context).pushNamed('owned_pokemons');
                },
              ),
            ),
            // The body of the home page
            body: Container(
              decoration: const BoxDecoration(
                // The background image of the home page (Nantes traffic map)
                image: DecorationImage(
                  image: AssetImage("assets/nantes_map_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  if (state.nearAStop) {
                    // TODO: Changer ça avec BLoC (add un event, push un state, push la navigation avec le listener)
                    // Push the pokemon at stop page onto the widget tree
                    Navigator.of(context).pushNamed('pokemon_at_stop');
                    // context.read<HomeBloc>().add(FindPokemon());
                  }
                },
                // The pokeball widget
                child: PokeballWidget(
                  isColored: state.nearAStop,
                ),
              ),
            ),
          );
        } else {
          // TODO: à la place de ça qui bloque l'appli, on devrait ajouter un event pour retourner sur l'état initial.
          return Text("${state.runtimeType}");
        }
      },
    );
  }
}

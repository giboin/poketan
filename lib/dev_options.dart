import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class DevOptions extends StatefulWidget {
  const DevOptions({super.key});

  @override
  State<DevOptions> createState() => _DevOptionsState();
}

class _DevOptionsState extends State<DevOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("options pour les devs"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child:const Text("effacer les données"),
                  onPressed: (){
                    HydratedBloc.storage.clear();
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text("ajouter Magicarpe lvl 1"),
                  onPressed: () {
                    context.read<OwnedPokemonsBloc>().add(NewPokemon(
                      pokemon: Pokemon(
                        name: "Magicarpe",
                        level: 1, 
                        pictureUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/129.png",
                        pokedexId: 129,
                        )
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text("ajouter Arceus lvl 100"),
                  onPressed: () {
                    context.read<OwnedPokemonsBloc>().add(NewPokemon(
                      pokemon: Pokemon(
                        name: "Arceus",
                        level: 100, 
                        pictureUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/493.png",
                        pokedexId: 493,
                        )
                        ));
                  },
                ),
              ),
          ],
          ),
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/owned_pokemons/presentation/controller/owned_pokemons_bloc.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails
({super.key, required this.pokemon});

final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController= TextEditingController(text:pokemon.name); 
    nameController.selection = TextSelection.fromPosition(TextPosition(offset: nameController.text.length));
    return Scaffold(
      appBar: AppBar(
        title:TextField(
          autocorrect:false,
          controller: nameController, 
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          onChanged:(str){
            Pokemon newPokemon = pokemon;
            newPokemon.name = str.trim();
            context.read<OwnedPokemonsBloc>().add(PokemonChanged(pokemon: newPokemon));
          },
        ),
        ),
        body: Column(children: [
          Image.network(pokemon.pictureUrl)
        ]),
    );
  }

  void newName(String newName){
    
  }
}
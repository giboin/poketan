// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';
import 'package:hackathon/pokemon_at_stop/domain/pokemon_adapter.dart';

void main() {
  testWidgets(
    'OwnedPokemonBloc fromJson and toJson',
    (widgetTester) async {
      final pokemon = Pokemon(
        name: "Pikachu",
        pokedexId: 25,
        pictureUrl:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
        level: 5,
      );
      final json = pokemon.toMap();
      final pokemon2 = PokemonAdapter.fromJson(json: json);
      expect(pokemon2, pokemon);
    },
  );
}

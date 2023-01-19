import 'package:hackathon/pokemon_at_stop/domain/pokemon.dart';

class PokemonAdapter {
  static Pokemon fromJson({
    required Map<String, dynamic> json,
  }) {
    return Pokemon(
        name: json["name"] ?? "Bulbazar",
        level: json["level"] ?? 5,
        pictureUrl: json["sprite_url"] ??
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        pokedexId: json["pokedex_id"] ?? 5);
  }

  static Pokemon fromJsonWithXp({
    required Map<String, dynamic> json,
  }) {
    return Pokemon.withXp(
        name: json["name"] ?? "Bulbazar",
        level: json["level"] ?? 5,
        xp: json["xp"]??0,
        pictureUrl: json["sprite_url"] ??
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        pokedexId: json["pokedex_id"] ?? 5);
  }
}

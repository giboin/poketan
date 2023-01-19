import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

/// A class that represents a Pokemon
class Pokemon with EquatableMixin {
  /// The name of the Pokemon
  String name;

  /// The url of the picture of the Pokemon from the PokeAPI
  String pictureUrl;

  /// The level of the Pokemon
  int level;

  /// The id of the Pokemon in the PokeAPI
  int pokedexId;

  /// The xp of the Pokemon
  int xp;

  /// Create a [Pokemon] object when exp is known
  Pokemon.withXp({
    required this.name,
    required this.level,
    required this.xp,
    required this.pictureUrl,
    required this.pokedexId,
  });

  /// Create a [Pokemon] object
  /// when exp is known, use [Pokemon.withXp] instead
  Pokemon({
    required this.name,
    required this.level,
    required this.pictureUrl,
    required this.pokedexId,
  }) : xp = pow(level, 3).toInt();

  /// Create a json from a [Pokemon] object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'xp': xp,
      'sprite_url': pictureUrl,
      'pokedex_id': pokedexId,
    };
  }

  /// Create a string json from a [Pokemon] object
  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  String toString() {
    return "$pokedexId: $name niveau $level";
  }

  @override
  List<Object?> get props => [name, level, xp, pictureUrl, pokedexId];
}

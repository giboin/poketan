import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

class Pokemon with EquatableMixin {
  String name;
  String pictureUrl;
  int level;
  int pokedexId;
  int xp;

  Pokemon.withXp({
    required this.name,
    required this.level,
    required this.xp,
    required this.pictureUrl,
    required this.pokedexId,
  });

  Pokemon({
    required this.name,
    required this.level,
    required this.pictureUrl,
    required this.pokedexId,
  }) : xp = pow(level, 3).toInt();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'xp': xp,
      'sprite_url': pictureUrl,
      'pokedex_id': pokedexId,
    };
  }

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

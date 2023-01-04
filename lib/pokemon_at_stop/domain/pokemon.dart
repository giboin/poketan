// ignore_for_file: file_names

class Pokemon {
  String name;
  String pictureUrl;
  int level;
  int? pokedexId;

  Pokemon({
    required this.name,
    required this.level,
    required this.pictureUrl,
    this.pokedexId,
  });

  String toJson() {
    return '{'
        '"pokemon": {'
        '"name": "$name",'
        '"pictureUrl": "$pictureUrl",'
        '"level": "$level",'
        '"pokedexId": "$pokedexId"'
        '}'
        '}';
  }
}

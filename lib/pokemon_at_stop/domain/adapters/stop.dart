// from json and toJson methods to help parse a Stop object

/// Stop (from the Tan API)
/// Pokemons can be found at a stop
class Stop {
  /// The name of the stop
  final String name;

  const Stop({
    required this.name,
  });

  /// Create a Stop object from a json
  static Stop fromJson({
    required Map<String, dynamic> json,
  }) {
    String name = json['stop_name'] ?? '';
    return Stop(name: name);
  }

  /// Create a json from a Stop object
  Map<String, dynamic> toJson() {
    return {
      "stop_name": '"$name"',
    };
  }

  @override
  String toString() {
    return '<Stop($name)>';
  }
}

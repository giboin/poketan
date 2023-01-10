// from json and toJson methods to help parse a Stop object

class Stop {
  final String name;

  const Stop({
    required this.name,
  });

  static Stop fromJson({
    required Map<String, dynamic> json,
  }) {
    String name = json['stop_name'] ?? '';
    return Stop(name: name);
  }

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

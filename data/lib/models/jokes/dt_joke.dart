const String jokesTable = "jokesTable";

class JokeFields {
  static const String id = "id";
  static const String value = "value";
}

class DTJoke {
  final String id;
  final String value;

  DTJoke(this.id, this.value);

  DTJoke.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        value = map['value'];

  Map<String, Object?> toJson() => {JokeFields.id: id, JokeFields.value: value};

  static DTJoke dtJokeFromJson(Map<String, Object?> json) =>
      DTJoke(json[JokeFields.id] as String, json[JokeFields.value] as String);

  @override
  String toString() {
    return '$id, $value';
  }
}

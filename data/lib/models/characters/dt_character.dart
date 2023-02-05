const String jokesTable = "jokesTable";

class CharacterFields {
  static const String name = "name";
  static const String image = "image";
}

class DTCharacter {
  final String name;
  final String image;

  DTCharacter(this.name, this.image);

  DTCharacter.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        image = map['image'];

  Map<String, Object?> toJson() =>
      {CharacterFields.name: name, CharacterFields.image: image};

  static DTCharacter dtCharacterFromJson(Map<String, Object?> json) =>
      DTCharacter(json[CharacterFields.name] as String,
          json[CharacterFields.image] as String);

  @override
  String toString() {
    return '$name, $image';
  }
}

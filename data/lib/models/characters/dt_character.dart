class CharacterFields {
  static const String id = "id";
  static const String name = "name";
  static const String image = "image";
  static const String status = "status";
  static const String species = "species";
}

class DTCharacter {
  final String id;
  final String name;
  final String image;
  final String status;
  final String species;

  DTCharacter(this.id, this.name, this.image, this.status, this.species);

  DTCharacter.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        species = map['species'];

  Map<String, Object?> toJson() => {
        CharacterFields.id: id,
        CharacterFields.name: name,
        CharacterFields.image: image,
        CharacterFields.status: status,
        CharacterFields.species: species,
      };

  static DTCharacter dtCharacterFromJson(Map<String, Object?> json) =>
      DTCharacter(
        json[CharacterFields.id] as String,
        json[CharacterFields.name] as String,
        json[CharacterFields.image] as String,
        json[CharacterFields.status] as String,
        json[CharacterFields.species] as String,
      );

  @override
  String toString() {
    return '$id, $name, $image, $status, $species';
  }
}

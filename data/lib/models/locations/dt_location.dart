class CharacterFields {
  static const String id = "id";
  static const String name = "name";
  static const String type = "type";
  static const String dimension = "dimension";
  static const String created = "created";
}

class DTLocation {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final String created;

  DTLocation(this.id, this.name, this.type, this.dimension, this.created);

  DTLocation.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        type = map['type'],
        dimension = map['dimension'],
        created = map['created'];

  Map<String, Object?> toJson() => {
        CharacterFields.id: id,
        CharacterFields.name: name,
        CharacterFields.type: type,
        CharacterFields.dimension: dimension,
        CharacterFields.created: created,
      };

  static DTLocation dtLocationFromJson(Map<String, Object?> json) => DTLocation(
        json[CharacterFields.id] as String,
        json[CharacterFields.name] as String,
        json[CharacterFields.type] as String,
        json[CharacterFields.dimension] as String,
        json[CharacterFields.created] as String,
      );

  @override
  String toString() {
    return '$id, $name, $type, $dimension, $created';
  }
}

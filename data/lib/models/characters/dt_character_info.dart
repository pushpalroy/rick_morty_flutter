class CharacterFields {
  static const String id = "id";
  static const String name = "name";
  static const String image = "image";
  static const String status = "status";
  static const String species = "species";
  static const String gender = "gender";
  static const String origin = "origin";
  static const String location = "location";
}

class DTCharacterInfo {
  final String? id, name, image, status, species, gender;
  final DTOrigin? origin;
  final DTLocation? location;

  DTCharacterInfo(this.id, this.name, this.image, this.status, this.species,
      this.gender, this.origin, this.location);

  DTCharacterInfo.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        species = map['species'],
        gender = map['gender'],
        origin = DTOrigin(map['origin']['id'], map['origin']['name']),
        location = DTLocation(map['origin']['id'], map['origin']['name']);

  Map<String, Object?> toJson() => {
        CharacterFields.id: id,
        CharacterFields.name: name,
        CharacterFields.image: image,
        CharacterFields.status: status,
        CharacterFields.species: species,
        CharacterFields.gender: gender,
        CharacterFields.origin: origin,
        CharacterFields.location: location,
      };

  static DTCharacterInfo dtCharacterFromJson(Map<String, Object?> json) =>
      DTCharacterInfo(
        json[CharacterFields.id] as String,
        json[CharacterFields.name] as String,
        json[CharacterFields.image] as String,
        json[CharacterFields.status] as String,
        json[CharacterFields.species] as String,
        json[CharacterFields.gender] as String,
        json[CharacterFields.origin] as DTOrigin,
        json[CharacterFields.location] as DTLocation,
      );

  @override
  String toString() {
    return '$id, $name, $image, $status, $species, $gender, $origin, $location';
  }
}

class DTOrigin {
  final String? id, name;

  DTOrigin(this.id, this.name);

  DTOrigin.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];

  Map<String, Object?> toJson() =>
      {CharacterFields.id: id, CharacterFields.name: name};

  static DTOrigin dtOriginFromJson(Map<String, Object?> json) => DTOrigin(
        json[CharacterFields.id] as String,
        json[CharacterFields.name] as String,
      );
}

class DTLocation {
  final String? id, name;

  DTLocation(this.id, this.name);

  DTLocation.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];

  Map<String, Object?> toJson() =>
      {CharacterFields.id: id, CharacterFields.name: name};

  static DTLocation dtLocationFromJson(Map<String, Object?> json) => DTLocation(
        json[CharacterFields.id] as String,
        json[CharacterFields.name] as String,
      );
}

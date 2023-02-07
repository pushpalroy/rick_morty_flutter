class CharacterInfo {
  final String id, name, image, status, species, gender;

  final Origin origin;
  final Location location;

  CharacterInfo(this.id, this.name, this.image, this.status, this.species,
      this.gender, this.origin, this.location);
}

class Origin {
  final String id, name;

  Origin(this.id, this.name);
}

class Location {
  final String id, name;

  Location(this.id, this.name);
}

class Location {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final String created;

  Location(this.id, this.name, this.type, this.dimension, this.created);
}

class LocationList {
  final List<Location> locationList;

  LocationList(this.locationList);
}

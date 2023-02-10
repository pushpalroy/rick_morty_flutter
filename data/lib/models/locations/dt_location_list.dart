import 'package:data/models/locations/dt_location.dart';

class DTLocationsList {
  final List<DTLocation> locationsList;

  DTLocationsList(this.locationsList);

  DTLocationsList.fromJson(Map<String, dynamic> map)
      : locationsList = List<DTLocation>.from(
            (map['locations']['results'].cast<Map<String, dynamic>>())
                .toList()
                .map((map) => DTLocation.fromJson(map)));

  @override
  String toString() {
    return '$locationsList';
  }
}

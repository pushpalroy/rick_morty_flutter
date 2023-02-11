import 'package:data/models/locations/dt_location.dart';

class DTLocationsList {
  DTLocationsList(this.locationsList);

  DTLocationsList.fromJson(Map<String, dynamic> map)
      : locationsList = List<DTLocation>.from(
          (map['locations']['results'].cast<Map<String, dynamic>>())
              .toList()
              .map(DTLocation.fromJson),
        );
  final List<DTLocation> locationsList;

  @override
  String toString() {
    return '$locationsList';
  }
}

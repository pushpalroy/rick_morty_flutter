import 'dart:async';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/locations/dm_location.dart';

abstract class LocationsRepository {
  Future<ApiResponse<LocationList>> getLocations();
}

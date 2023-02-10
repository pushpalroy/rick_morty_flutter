import 'dart:async';
import 'package:clean_architecture/clean_architecture.dart';
import 'package:clean_architecture/src/usecase.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/characters/dm_character.dart';
import 'package:domain/entities/locations/dm_location.dart';
import 'package:domain/repositories/characters/characters_repo.dart';
import 'package:domain/repositories/locations/locations_repo.dart';

import '../validations.dart';

class GetLocationsUseCase extends UseCase<LocationListUseCaseResponse, void> {
  final LocationsRepository repo;

  GetLocationsUseCase(this.repo);

  @override
  Future<Stream<LocationListUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<LocationListUseCaseResponse>();
    try {
      // Fetch from repository
      final locationList = await repo.getLocations();
      // Adding it triggers the .onNext() in the `Observer`
      controller.add(LocationListUseCaseResponse(locationList));
      logger.finest('GetLocationsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetLocationsUseCase failure.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class LocationListUseCaseResponse {
  final ApiResponse<LocationList> locationList;

  LocationListUseCaseResponse(this.locationList);
}

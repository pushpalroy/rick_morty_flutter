import 'package:data/mapper/locations/locations_mappers.dart';
import 'package:data/models/locations/dt_location_list.dart';
import 'package:data/sources/network/rickmorty/rick_morty_services.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/locations/dm_location.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/repositories/locations/locations_repo.dart';

@Injectable(as: LocationsRepository)
class LocationsRepositoryImpl implements LocationsRepository {
  final LocationListMapper locationListMapper;
  final RickMortyServices services;

  LocationsRepositoryImpl(this.services, this.locationListMapper);

  @override
  Future<ApiResponse<LocationList>> getLocations() async {
    final response = await services.getLocationsList();
    if (response is Success) {
      try {
        final locationList = (response as Success).data as DTLocationsList;
        return Success(data: locationListMapper.mapToDomain(locationList));
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }
}

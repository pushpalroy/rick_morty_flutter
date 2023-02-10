import 'package:data/models/locations/dt_location_list.dart';
import 'package:domain/entities/locations/dm_location.dart';
import 'package:injectable/injectable.dart';
import 'package:data/mapper/entity_mapper.dart';
import '../../models/locations/dt_location.dart';

@injectable
class LocationListMapper extends EntityMapper<LocationList, DTLocationsList> {
  LocationMapper locationMapper;

  LocationListMapper(this.locationMapper);

  @override
  DTLocationsList mapToData(LocationList model) {
    return DTLocationsList(
        model.locationList.map((e) => locationMapper.mapToData(e)).toList());
  }

  @override
  LocationList mapToDomain(DTLocationsList entity) {
    return LocationList(entity.locationsList
        .map((e) => locationMapper.mapToDomain(e))
        .toList());
  }
}

@injectable
class LocationMapper extends EntityMapper<Location, DTLocation> {
  @override
  DTLocation mapToData(Location model) {
    return DTLocation(
        model.id, model.name, model.type, model.dimension, model.created);
  }

  @override
  Location mapToDomain(DTLocation entity) {
    return Location(
        entity.id, entity.name, entity.type, entity.dimension, entity.created);
  }
}

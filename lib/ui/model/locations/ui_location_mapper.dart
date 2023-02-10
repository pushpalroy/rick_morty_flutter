import 'package:domain/entities/locations/dm_location.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/mapper/ui_model_mapper.dart';
import 'package:rick_morty_flutter/ui/model/locations/ui_location.dart';

@injectable
class UiLocationMapper extends UiModelMapper<LocationList, UiLocationList> {
  @override
  LocationList mapToDomain(UiLocationList modelItem) {
    return LocationList(modelItem.locations
        .map((e) => Location(e.id, e.name, e.type, e.dimension, e.created))
        .toList());
  }

  @override
  UiLocationList mapToPresentation(LocationList model) {
    return UiLocationList(model.locationList
        .map((e) => UiLocation(e.id, e.name, e.type, e.dimension, e.created))
        .toList());
  }
}

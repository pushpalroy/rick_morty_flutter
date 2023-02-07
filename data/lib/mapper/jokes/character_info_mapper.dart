import 'package:data/models/characters/dt_character_info.dart';
import 'package:domain/entities/characters/dm_character_info.dart';
import 'package:injectable/injectable.dart';
import 'package:data/mapper/entity_mapper.dart';

@injectable
class CharacterInfoMapper extends EntityMapper<CharacterInfo, DTCharacterInfo> {
  @override
  DTCharacterInfo mapToData(CharacterInfo model) {
    return DTCharacterInfo(
        model.id,
        model.name,
        model.image,
        model.status,
        model.species,
        model.gender,
        DTOrigin(model.origin.id, model.origin.name),
        DTLocation(model.origin.id, model.origin.name));
  }

  @override
  CharacterInfo mapToDomain(DTCharacterInfo entity) {
    return CharacterInfo(
        entity.id,
        entity.name,
        entity.image,
        entity.status,
        entity.species,
        entity.gender,
        Origin(entity.origin.id, entity.origin.name),
        Location(entity.origin.id, entity.origin.name));
  }
}

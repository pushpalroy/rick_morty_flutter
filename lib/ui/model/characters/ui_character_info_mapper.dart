import 'package:domain/entities/characters/dm_character_info.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/mapper/ui_model_mapper.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_info.dart';

@injectable
class UiCharacterInfoMapper
    extends UiModelMapper<CharacterInfo, UiCharacterInfo> {
  @override
  CharacterInfo mapToDomain(UiCharacterInfo modelItem) {
    return CharacterInfo(
        modelItem.id,
        modelItem.name,
        modelItem.image,
        modelItem.status,
        modelItem.species,
        modelItem.gender,
        Origin("", modelItem.origin),
        Location("", modelItem.location));
  }

  @override
  UiCharacterInfo mapToPresentation(CharacterInfo model) {
    return UiCharacterInfo(model.id, model.name, model.image, model.status,
        model.species, model.gender, model.origin.name, model.origin.name);
  }
}

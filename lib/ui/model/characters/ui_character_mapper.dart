import 'package:injectable/injectable.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:domain/mapper/ui_model_mapper.dart';
import 'package:domain/entities/characters/dm_character.dart';

@injectable
class UiCharacterMapper extends UiModelMapper<CharacterList, UiCharacterList> {
  @override
  CharacterList mapToDomain(UiCharacterList modelItem) {
    return CharacterList(modelItem.characters
        .map((e) => Character(e.id, e.name, e.image, e.status, e.species))
        .toList());
  }

  @override
  UiCharacterList mapToPresentation(CharacterList model) {
    return UiCharacterList(model.characterList
        .map((e) => UiCharacter(e.id, e.name, e.image, e.status, e.species))
        .toList());
  }
}

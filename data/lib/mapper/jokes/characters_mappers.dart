import 'package:data/models/characters/dt_character.dart';
import 'package:data/models/characters/dt_character_list.dart';
import 'package:domain/entities/characters/dm_character.dart';
import 'package:injectable/injectable.dart';
import 'package:data/mapper/entity_mapper.dart';

@injectable
class CharacterListMapper
    extends EntityMapper<CharacterList, DTCharactersList> {
  CharacterMapper characterMapper;

  CharacterListMapper(this.characterMapper);

  @override
  DTCharactersList mapToData(CharacterList model) {
    return DTCharactersList(
        model.characterList.map((e) => characterMapper.mapToData(e)).toList());
  }

  @override
  CharacterList mapToDomain(DTCharactersList entity) {
    return CharacterList(entity.charactersList
        .map((e) => characterMapper.mapToDomain(e))
        .toList());
  }
}

@injectable
class CharacterMapper extends EntityMapper<Character, DTCharacter> {
  @override
  DTCharacter mapToData(Character model) {
    return DTCharacter(model.name, model.image);
  }

  @override
  Character mapToDomain(DTCharacter entity) {
    return Character(entity.name, entity.image);
  }
}

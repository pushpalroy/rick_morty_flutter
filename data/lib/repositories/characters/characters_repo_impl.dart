import 'package:data/models/characters/dt_character_info.dart';
import 'package:data/sources/network/rickmorty/rick_morty_services.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/characters/dm_character_info.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/repositories/characters/characters_repo.dart';
import 'package:domain/entities/characters/dm_character.dart';
import '../../mapper/jokes/character_info_mapper.dart';
import '../../mapper/jokes/characters_mappers.dart';
import '../../models/characters/dt_character_list.dart';

@Injectable(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  final CharacterListMapper characterListMapper;
  final CharacterInfoMapper characterInfoMapper;
  final RickMortyServices services;

  CharactersRepositoryImpl(
      this.services, this.characterListMapper, this.characterInfoMapper);

  @override
  Future<ApiResponse<CharacterList>> getRickAndMortyCharacters(int page) async {
    final response = await services.getCharactersList(page);
    if (response is Success) {
      try {
        final characterList = (response as Success).data as DTCharactersList;
        return Success(data: characterListMapper.mapToDomain(characterList));
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }

  @override
  Future<ApiResponse<CharacterInfo>> getCharacterInfo(int id) async {
    final response = await services.getCharacterInfo(id);
    if (response is Success) {
      try {
        final characterInfo = (response as Success).data as DTCharacterInfo;
        return Success(data: characterInfoMapper.mapToDomain(characterInfo));
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }
}

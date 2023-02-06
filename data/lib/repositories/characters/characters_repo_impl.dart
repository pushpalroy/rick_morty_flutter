import 'package:data/sources/network/rickmorty/rick_morty_services.dart';
import 'package:domain/entities/api_response.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/repositories/characters/characters_repo.dart';
import 'package:domain/entities/characters/dm_character.dart';
import '../../mapper/jokes/characters_mappers.dart';
import '../../models/characters/dt_character_list.dart';

@Injectable(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  final CharacterListMapper mapper;
  final RickMortyServices services;

  CharactersRepositoryImpl(this.services, this.mapper);

  @override
  Future<ApiResponse<CharacterList>> getRickAndMortyCharacters(int page) async {
    final response = await services.getCharactersList(page);
    if (response is Success) {
      try {
        final characterList = (response as Success).data as DTCharactersList;
        return Success(data: mapper.mapToDomain(characterList));
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }
}

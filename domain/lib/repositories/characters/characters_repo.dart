import 'dart:async';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/characters/dm_character.dart';

abstract class CharactersRepository {
  Future<ApiResponse<CharacterList>> getRickAndMortyCharacters(int page);
}

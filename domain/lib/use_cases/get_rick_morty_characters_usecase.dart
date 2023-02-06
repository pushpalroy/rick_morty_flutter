import 'dart:async';
import 'package:clean_architecture/clean_architecture.dart';
import 'package:clean_architecture/src/usecase.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/characters/dm_character.dart';
import 'package:domain/repositories/characters/characters_repo.dart';

class GetRickMortyCharactersUseCase
    extends UseCase<CharacterListUseCaseResponse, void> {
  final CharactersRepository repo;

  GetRickMortyCharactersUseCase(this.repo);

  @override
  Future<Stream<CharacterListUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<CharacterListUseCaseResponse>();
    try {
      // Fetch from repository
      final characterList = await repo.getRickAndMortyCharacters();
      // Adding it triggers the .onNext() in the `Observer`
      controller.add(CharacterListUseCaseResponse(characterList));
      logger.finest('GetRickMortyCharactersUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetRickMortyCharactersUseCase failure.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class CharacterListUseCaseResponse {
  final ApiResponse<CharacterList> characterList;

  CharacterListUseCaseResponse(this.characterList);
}

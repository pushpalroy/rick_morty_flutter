import 'dart:async';
import 'package:clean_architecture/clean_architecture.dart';
import 'package:clean_architecture/src/usecase.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/characters/dm_character.dart';
import 'package:domain/entities/characters/dm_character_info.dart';
import 'package:domain/repositories/characters/characters_repo.dart';

import '../validations.dart';

class GetCharacterInfoUseCase
    extends UseCase<GetCharacterInfoUseCaseResponse, int> {
  final CharactersRepository repo;

  GetCharacterInfoUseCase(this.repo);

  @override
  Future<Stream<GetCharacterInfoUseCaseResponse>> buildUseCaseStream(
      int? page) async {
    final controller = StreamController<GetCharacterInfoUseCaseResponse>();
    try {
      if (page != null) {
        // Fetch from repository
        final characterInfo = await repo.getCharacterInfo(page);
        // Adding it triggers the .onNext() in the `Observer`
        controller.add(GetCharacterInfoUseCaseResponse(characterInfo));
        logger.finest('GetCharacterInfoUseCase successful.');
        controller.close();
      } else {
        logger.severe('page is null.');
        controller.addError(InvalidRequestException());
      }
    } catch (e) {
      logger.severe('GetCharacterInfoUseCase failure.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetCharacterInfoUseCaseResponse {
  final ApiResponse<CharacterInfo> characterInfo;

  GetCharacterInfoUseCaseResponse(this.characterInfo);
}

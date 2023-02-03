import 'dart:async';

import 'package:clean_architecture/clean_architecture.dart';
import 'package:clean_architecture/src/usecase.dart';
import 'package:domain/entities/api_response.dart';
import 'package:domain/entities/jokes/dm_joke_list.dart';
import 'package:domain/repositories/jokes/jokes_repository.dart';

class GetFiveRandomJokesUseCase
    extends UseCase<GetJokeListUseCaseResponse, void> {
  final JokesRepository jokesRepository;

  GetFiveRandomJokesUseCase(this.jokesRepository);

  @override
  Future<Stream<GetJokeListUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetJokeListUseCaseResponse>();
    try {
      final jokeList = await jokesRepository.getFiveRandomJokes();
      // Adding it triggers the .onNext() in the `Observer`
      controller.add(GetJokeListUseCaseResponse(jokeList));
      logger.finest('GetFiveRandomJokesUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetUserUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetJokeListUseCaseResponse {
  final ApiResponse<JokesListWithType> jokeList;

  GetJokeListUseCaseResponse(this.jokeList);
}

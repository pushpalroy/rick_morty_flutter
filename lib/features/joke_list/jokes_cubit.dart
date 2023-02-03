import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/jokes/ui_joke.dart';
import 'package:rick_morty_flutter/ui/model/jokes/ui_jokes_mapper.dart';
import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/use_cases/get_five_random_jokes_usecase.dart';

class JokesCubit extends Cubit<UiState<UIJokeList>> {
  final getFiveRandomJokesUseCase = GetIt.I.get<GetFiveRandomJokesUseCase>();
  final jokeMapper = GetIt.I.get<UIJokeMapper>();

  JokesCubit() : super(Initial()) {
    loadJokes();
  }

  void loadJokes() {
    emit(Loading());
    getFiveRandomJokesUseCase.perform(handleResponse, error, complete);
  }

  void handleResponse(GetJokeListUseCaseResponse? response) {
    final useCaseResponseJokes = response?.jokeList;
    if (useCaseResponseJokes == null) {
      emit(Failure(exception: Exception("Couldn't fetch jokes!")));
    } else {
      if (useCaseResponseJokes is api_response.Failure) {
        emit(Failure(
            exception: (useCaseResponseJokes as api_response.Failure).error));
      } else if (useCaseResponseJokes is api_response.Success) {
        var jokes = (useCaseResponseJokes as api_response.Success);
        final uiJokes = jokeMapper.mapToPresentation(jokes.data);
        emit(Success(data: uiJokes));
      }
    }
  }

  void complete() {}

  error(e) {
    emit(Failure(exception: e));
  }

  @override
  Future<void> close() {
    getFiveRandomJokesUseCase.dispose();
    return super.close();
  }
}

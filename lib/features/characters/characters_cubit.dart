import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_mapper.dart';
import 'package:domain/entities/api_response.dart' as api_response;

class CharactersCubit extends Cubit<UiState<UiCharacterList>> {
  final uiCharacterMapper = GetIt.I.get<UiCharacterMapper>();
  final getRickMortyCharactersUseCase =
      GetIt.I.get<GetRickMortyCharactersUseCase>();

  CharactersCubit() : super(Initial()) {
    loadCharacters();
  }

  void loadCharacters() {
    emit(Loading());
    getRickMortyCharactersUseCase.perform(handleResponse, error, complete);
  }

  void handleResponse(CharacterListUseCaseResponse? response) {
    final useCaseResponseCharacters = response?.characterList;
    if (useCaseResponseCharacters == null) {
      emit(Failure(exception: Exception("Couldn't fetch characters!")));
    } else {
      if (useCaseResponseCharacters is api_response.Failure) {
        emit(Failure(
            exception:
                (useCaseResponseCharacters as api_response.Failure).error));
      } else if (useCaseResponseCharacters is api_response.Success) {
        var characters = (useCaseResponseCharacters as api_response.Success);
        final uiCharacters =
            uiCharacterMapper.mapToPresentation(characters.data);
        emit(Success(data: uiCharacters));
      }
    }
  }

  void complete() {}

  error(e) {
    emit(Failure(exception: e));
  }

  @override
  Future<void> close() {
    getRickMortyCharactersUseCase.dispose();
    return super.close();
  }
}
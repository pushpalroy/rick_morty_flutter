import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_mapper.dart';
import 'package:domain/entities/api_response.dart' as api_response;

class CharactersCubit extends Cubit<UiState<List<UiCharacter>>> {
  final uiMapper = GetIt.I.get<UiCharacterMapper>();
  final getRickMortyCharactersUseCase =
      GetIt.I.get<GetRickMortyCharactersUseCase>();
  final List<UiCharacter> charactersToDisplayInUi = [];
  late bool isFilterRequest = false;
  late String nameFilter = '';

  CharactersCubit() : super(Initial()) {
    loadCharacters();
  }

  /// Load Rick & Morty characters
  void loadCharacters([int? page = 1]) {
    if (page == 1) {
      emit(Loading());
    }
    isFilterRequest = nameFilter.isNotEmpty;
    getRickMortyCharactersUseCase.perform(handleResponse, error, complete,
        CharacterListReqParams(page: page, nameFilter: nameFilter));
  }

  void setNameFilter([String nameFilter = '']) {
    this.nameFilter = nameFilter;
  }

  /// Handle response data
  void handleResponse(CharacterListUseCaseResponse? response) {
    final responseData = response?.characterList;
    if (responseData == null) {
      emit(Failure(exception: Exception("Couldn't fetch characters!")));
    } else {
      if (responseData is api_response.Failure) {
        emit(Failure(exception: (responseData as api_response.Failure).error));
      } else if (responseData is api_response.Success) {
        var characters = (responseData as api_response.Success);
        final uiCharacters = uiMapper.mapToPresentation(characters.data);
        if (uiCharacters.characters.isNotEmpty) {
          if (isFilterRequest) {
            charactersToDisplayInUi.clear();
          }
          charactersToDisplayInUi.addAll(uiCharacters.characters);
        }
        emit(Success(data: charactersToDisplayInUi));
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

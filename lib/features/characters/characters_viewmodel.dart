import 'dart:developer';
import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/entities/characters/dm_character.dart';
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_mapper.dart';

class CharactersViewModel extends ChangeNotifier {
  final _uiMapper = GetIt.I.get<UiCharacterMapper>();
  final _getRickMortyCharactersUseCase =
      GetIt.I.get<GetRickMortyCharactersUseCase>();

  late String nameFilter = '';
  bool isPageLoadInProgress = false;
  int page = 1;

  UiState<CharactersUiState> get charactersUiState => _charactersUiState;

  set charactersUiState(UiState<CharactersUiState> state) {
    _charactersUiState = state;
    notifyListeners();
  }

  /// Load Rick & Morty characters
  void loadCharacters() {
    if (page == 1) {
      charactersUiState = Loading();
    }
    _isFilterRequest = nameFilter.isNotEmpty;
    _getRickMortyCharactersUseCase.perform(
      handleResponse,
      error,
      complete,
      CharacterListReqParams(page: page, nameFilter: nameFilter),
    );
  }

  /// Handle response data
  void handleResponse(CharacterListUseCaseResponse? response) {
    final responseData = response?.characterList;
    if (responseData == null) {
      charactersUiState =
          Failure(exception: Exception("Couldn't fetch characters!"));
    } else {
      if (responseData is api_response.Failure) {
        charactersUiState =
            Failure(exception: (responseData as api_response.Failure).error);
      } else if (responseData is api_response.Success) {
        final characters = responseData as api_response.Success;
        final uiCharacters =
            _uiMapper.mapToPresentation(characters.data as CharacterList);
        if (uiCharacters.characters.isNotEmpty) {
          if (_isFilterRequest) {
            _charactersToDisplayInUi.clear();
          }
          _charactersToDisplayInUi.addAll(uiCharacters.characters);
        }
        charactersUiState = Success(
          data: CharactersUiState(_charactersToDisplayInUi, null),
        );
        notifyListeners();
      }
    }
    isPageLoadInProgress = false;
  }

  void complete() {
    log('Fetching characters list is complete.');
  }

  void error(Object e) {
    log('Error in fetching characters list');
    if (e is Exception) {
      log('Error in fetching characters list: $e');
      charactersUiState = Failure(exception: e);
      notifyListeners();
    }
  }

  // INTERNALS
  late bool _isFilterRequest = false;
  final List<UiCharacter> _charactersToDisplayInUi = [];
  UiState<CharactersUiState> _charactersUiState = Loading();
}

class CharactersUiState {
  CharactersUiState(
    this.data,
    this.exception,
  );

  List<UiCharacter> data = [];
  Exception? exception;
}

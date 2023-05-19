import 'dart:developer';

import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/entities/characters/dm_character.dart';
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_mapper.dart';

class CharactersCubit extends Cubit<UiState<List<UiCharacter>>> {
  CharactersCubit() : super(Initial()) {
    loadCharacters();
  }

  final _uiMapper = GetIt.I.get<UiCharacterMapper>();
  final _getRickMortyCharactersUseCase =
      GetIt.I.get<GetRickMortyCharactersUseCase>();
  final List<UiCharacter> _charactersToDisplayInUi = [];
  late bool _isFilterRequest = false;

  late String nameFilter = '';
  bool isPageLoadInProgress = false;
  int page = 1;

  /// Load Rick & Morty characters
  void loadCharacters() {
    if (page == 1) {
      emit(Loading());
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
      emit(Failure(exception: Exception("Couldn't fetch characters!")));
    } else {
      if (responseData is api_response.Failure) {
        emit(Failure(exception: (responseData as api_response.Failure).error));
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
        emit(Success(data: _charactersToDisplayInUi));
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
      emit(Failure(exception: e));
    }
  }

  @override
  Future<void> close() {
    _getRickMortyCharactersUseCase.dispose();
    return super.close();
  }
}

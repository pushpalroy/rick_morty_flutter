import 'dart:developer';

import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/entities/characters/dm_character_info.dart';
import 'package:domain/use_cases/get_character_info_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_info.dart';

import '../../../ui/model/characters/ui_character_info_mapper.dart';

class CharacterInfoViewModel extends ChangeNotifier {
  CharacterInfoViewModel({required this.characterId});

  final String characterId;
  final _uiMapper = GetIt.I.get<UiCharacterInfoMapper>();
  final _getCharacterInfoUseCase = GetIt.I.get<GetCharacterInfoUseCase>();

  UiState<CharacterInfoUiState> get characterInfoUiState =>
      _characterInfoUiState;

  set characterInfoUiState(UiState<CharacterInfoUiState> state) {
    _characterInfoUiState = state;
    notifyListeners();
  }

  /// Load character information
  void loadCharacterInfo({required int id}) {
    characterInfoUiState = Loading();
    _getCharacterInfoUseCase.perform(handleResponse, error, complete, id);
  }

  /// Handle response data
  void handleResponse(GetCharacterInfoUseCaseResponse? response) {
    final responseData = response?.characterInfo;
    if (responseData == null) {
      characterInfoUiState =
          Failure(exception: Exception("Couldn't fetch character info!"));
    } else {
      if (responseData is api_response.Failure) {
        characterInfoUiState =
            Failure(exception: (responseData as api_response.Failure).error);
      } else if (responseData is api_response.Success) {
        final characters = responseData as api_response.Success;
        final uiCharacterInfo =
            _uiMapper.mapToPresentation(characters.data as CharacterInfo);
        characterInfoUiState = Success(
          data: CharacterInfoUiState(uiCharacterInfo, null),
        );
      }
    }
  }

  void complete() {
    log('Fetching character information is complete.');
  }

  void error(Object e) {
    log('Error in fetching character information');
    if (e is Exception) {
      log('Error in fetching characters information: $e');
      characterInfoUiState = Failure(exception: e);
    }
  }
}

UiState<CharacterInfoUiState> _characterInfoUiState = Loading();

class CharacterInfoUiState {
  CharacterInfoUiState(
    this.data,
    this.exception,
  );

  UiCharacterInfo data;
  Exception? exception;
}

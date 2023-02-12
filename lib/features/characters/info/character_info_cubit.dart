import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/entities/characters/dm_character_info.dart';
import 'package:domain/use_cases/get_character_info_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';

import '../../../ui/model/characters/ui_character_info.dart';
import '../../../ui/model/characters/ui_character_info_mapper.dart';

class CharacterInfoCubit extends Cubit<UiState<UiCharacterInfo>> {
  CharacterInfoCubit(String characterId) : super(Initial()) {
    loadCharacterInfo(id: int.parse(characterId));
  }

  final _uiMapper = GetIt.I.get<UiCharacterInfoMapper>();
  final _getCharacterInfoUseCase = GetIt.I.get<GetCharacterInfoUseCase>();

  /// Load character information
  void loadCharacterInfo({required int id}) {
    emit(Loading());
    _getCharacterInfoUseCase.perform(handleResponse, error, complete, id);
  }

  /// Handle response data
  void handleResponse(GetCharacterInfoUseCaseResponse? response) {
    final responseData = response?.characterInfo;
    if (responseData == null) {
      emit(Failure(exception: Exception("Couldn't fetch character info!")));
    } else {
      if (responseData is api_response.Failure) {
        emit(Failure(exception: (responseData as api_response.Failure).error));
      } else if (responseData is api_response.Success) {
        final characters = responseData as api_response.Success;
        final uiCharacterInfo =
            _uiMapper.mapToPresentation(characters.data as CharacterInfo);
        emit(Success(data: uiCharacterInfo));
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
      emit(Failure(exception: e));
    }
  }

  @override
  Future<void> close() {
    _getCharacterInfoUseCase.dispose();
    return super.close();
  }
}

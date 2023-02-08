import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:domain/use_cases/get_character_info_usecase.dart';
import 'package:domain/entities/api_response.dart' as api_response;
import '../../ui/model/characters/ui_character_info.dart';
import '../../ui/model/characters/ui_character_info_mapper.dart';

class CharacterInfoCubit extends Cubit<UiState<UiCharacterInfo>> {
  final uiMapper = GetIt.I.get<UiCharacterInfoMapper>();
  final getCharacterInfoUseCase = GetIt.I.get<GetCharacterInfoUseCase>();

  CharacterInfoCubit() : super(Initial()) {
    loadCharacterInfo(id: 1);
  }

  /// Load character information
  void loadCharacterInfo({required int id}) {
    emit(Loading());
    getCharacterInfoUseCase.perform(handleResponse, error, complete, id);
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
        var characters = (responseData as api_response.Success);
        final uiCharacterInfo = uiMapper.mapToPresentation(characters.data);
        emit(Success(data: uiCharacterInfo));
      }
    }
  }

  void complete() {}

  error(e) {
    if (e is Exception) {
      emit(Failure(exception: e));
    }
  }

  @override
  Future<void> close() {
    getCharacterInfoUseCase.dispose();
    return super.close();
  }
}

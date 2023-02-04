import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_mapper.dart';

class DashboardCubit extends Cubit<UiState<UiCharacterList>> {
  final uiCharacterMapper = GetIt.I.get<UiCharacterMapper>();

  DashboardCubit() : super(Initial()) {
    loadDashboard();
  }

  void loadDashboard() {
    emit(Loading());
  }
}

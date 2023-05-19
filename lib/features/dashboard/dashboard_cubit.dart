import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character_mapper.dart';

class DashboardCubit extends Cubit<UiState<UiCharacterList>> {

  DashboardCubit() : super(Initial()) {
    loadDashboard();
  }
  final uiCharacterMapper = GetIt.I.get<UiCharacterMapper>();

  void loadDashboard() {
    emit(Loading());
  }
}

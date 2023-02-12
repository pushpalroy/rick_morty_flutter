import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/entities/locations/dm_location.dart';
import 'package:domain/use_cases/get_locations_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/locations/ui_location.dart';

import '../../ui/model/locations/ui_location_mapper.dart';

class LocationsCubit extends Cubit<UiState<List<UiLocation>>> {
  LocationsCubit() : super(Initial()) {
    loadLocations();
  }

  final _uiMapper = GetIt.I.get<UiLocationMapper>();
  final _getLocationsUseCase = GetIt.I.get<GetLocationsUseCase>();
  final List<UiLocation> _locationsToDisplayInUi = [];

  /// Load Rick & Morty locations
  void loadLocations() {
    emit(Loading());
    _getLocationsUseCase.perform(handleResponse, error, complete);
  }

  /// Handle response data
  void handleResponse(LocationListUseCaseResponse? response) {
    final responseData = response?.locationList;
    if (responseData == null) {
      emit(Failure(exception: Exception("Couldn't fetch locations!")));
    } else {
      if (responseData is api_response.Failure) {
        emit(Failure(exception: (responseData as api_response.Failure).error));
      } else if (responseData is api_response.Success) {
        final locations = responseData as api_response.Success;
        final uiLocations =
            _uiMapper.mapToPresentation(locations.data as LocationList);
        if (uiLocations.locations.isNotEmpty) {
          _locationsToDisplayInUi.addAll(uiLocations.locations);
        }
        emit(Success(data: _locationsToDisplayInUi));
      }
    }
  }

  void complete() {
    log('Fetching locations list is complete.');
  }

  void error(Object e) {
    log('Error in fetching locations list.');
    if (e is Exception) {
      log('Error in fetching locations list: $e');
      emit(Failure(exception: e));
    }
  }

  @override
  Future<void> close() {
    _getLocationsUseCase.dispose();
    return super.close();
  }
}

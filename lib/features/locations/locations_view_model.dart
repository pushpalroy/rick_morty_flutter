import 'dart:developer';
import 'package:domain/entities/api_response.dart' as api_response;
import 'package:domain/entities/locations/dm_location.dart';
import 'package:domain/use_cases/get_locations_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import '../../ui/model/locations/ui_location.dart';
import '../../ui/model/locations/ui_location_mapper.dart';

class LocationsViewModel extends ChangeNotifier {
  final _uiMapper = GetIt.I.get<UiLocationMapper>();
  final _getLocationsUseCase = GetIt.I.get<GetLocationsUseCase>();

  UiState<LocationsUiState> get locationsUiState => _locationsUiState;

  set locationsUiState(UiState<LocationsUiState> state) {
    _locationsUiState = state;
    notifyListeners();
  }

  /// Load Rick & Morty locations
  void loadLocations() {
    locationsUiState = Loading();
    _getLocationsUseCase.perform(handleResponse, error, complete);
  }

  /// Handle response data
  void handleResponse(LocationListUseCaseResponse? response) {
    final responseData = response?.locationList;
    if (responseData == null) {
      locationsUiState =
          Failure(exception: Exception("Couldn't fetch locations!"));
    } else {
      if (responseData is api_response.Failure) {
        locationsUiState =
            Failure(exception: (responseData as api_response.Failure).error);
      } else if (responseData is api_response.Success) {
        final locations = responseData as api_response.Success;
        final uiLocations =
            _uiMapper.mapToPresentation(locations.data as LocationList);
        if (uiLocations.locations.isNotEmpty) {
          _locationsToDisplayInUi.addAll(uiLocations.locations);
        }
        locationsUiState = Success(
          data: LocationsUiState(_locationsToDisplayInUi, null),
        );
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
      locationsUiState = Failure(exception: e);
    }
  }
}

UiState<LocationsUiState> _locationsUiState = Loading();
final List<UiLocation> _locationsToDisplayInUi = [];

class LocationsUiState {
  LocationsUiState(
    this.data,
    this.exception,
  );

  List<UiLocation> data;
  Exception? exception;
}

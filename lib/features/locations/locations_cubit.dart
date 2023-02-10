import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/get_locations_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:domain/entities/api_response.dart' as api_response;
import 'package:rick_morty_flutter/ui/model/locations/ui_location.dart';
import '../../ui/model/locations/ui_location_mapper.dart';

class LocationsCubit extends Cubit<UiState<List<UiLocation>>> {
  final uiMapper = GetIt.I.get<UiLocationMapper>();
  final getLocationsUseCase = GetIt.I.get<GetLocationsUseCase>();
  final List<UiLocation> locationsToDisplayInUi = [];

  LocationsCubit() : super(Initial()) {
    loadLocations();
  }

  /// Load Rick & Morty locations
  void loadLocations() {
    emit(Loading());
    getLocationsUseCase.perform(handleResponse, error, complete);
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
        var locations = (responseData as api_response.Success);
        final uiLocations = uiMapper.mapToPresentation(locations.data);
        if (uiLocations.locations.isNotEmpty) {
          locationsToDisplayInUi.addAll(uiLocations.locations);
        }
        emit(Success(data: locationsToDisplayInUi));
      }
    }
  }

  void complete() {}

  error(e) {
    emit(Failure(exception: e));
  }

  @override
  Future<void> close() {
    getLocationsUseCase.dispose();
    return super.close();
  }
}

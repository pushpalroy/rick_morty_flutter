import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart';
import 'package:domain/use_cases/get_character_info_usecase.dart';
import 'package:domain/use_cases/get_locations_usecase.dart';

@module
abstract class UseCaseModule {
  GetRickMortyCharactersUseCase get getRickMortyCharactersUseCase =>
      GetRickMortyCharactersUseCase(GetIt.instance.get());

  GetCharacterInfoUseCase get getCharacterInfoUseCase =>
      GetCharacterInfoUseCase(GetIt.instance.get());

  GetLocationsUseCase get getLocationsUseCase =>
      GetLocationsUseCase(GetIt.instance.get());
}

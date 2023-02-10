// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/repositories/characters/characters_repo.dart' as _i11;
import 'package:domain/repositories/locations/locations_repo.dart' as _i13;
import 'package:domain/use_cases/get_character_info_usecase.dart' as _i5;
import 'package:domain/use_cases/get_locations_usecase.dart' as _i6;
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'mapper/characters/character_info_mapper.dart' as _i3;
import 'mapper/characters/characters_mappers.dart' as _i4;
import 'mapper/locations/locations_mappers.dart' as _i9;
import 'repositories/characters/characters_repo_impl.dart' as _i12;
import 'repositories/locations/locations_repo_impl.dart' as _i14;
import 'sources/network/graphql/graphql_service.dart' as _i8;
import 'sources/network/rickmorty/rick_morty_services.dart' as _i10;
import 'usecases/usecase_module.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt $initGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final useCaseModule = _$UseCaseModule();
    gh.factory<_i3.CharacterInfoMapper>(() => _i3.CharacterInfoMapper());
    gh.factory<_i4.CharacterMapper>(() => _i4.CharacterMapper());
    gh.factory<_i5.GetCharacterInfoUseCase>(
        () => useCaseModule.getCharacterInfoUseCase);
    gh.factory<_i6.GetLocationsUseCase>(
        () => useCaseModule.getLocationsUseCase);
    gh.factory<_i7.GetRickMortyCharactersUseCase>(
        () => useCaseModule.getRickMortyCharactersUseCase);
    gh.singleton<_i8.GraphQLService>(_i8.GraphQLService());
    gh.factory<_i9.LocationMapper>(() => _i9.LocationMapper());
    gh.factory<_i10.RickMortyServices>(
        () => _i10.RickMortyServices(get<_i8.GraphQLService>()));
    gh.factory<_i4.CharacterListMapper>(
        () => _i4.CharacterListMapper(get<_i4.CharacterMapper>()));
    gh.factory<_i11.CharactersRepository>(() => _i12.CharactersRepositoryImpl(
          get<_i10.RickMortyServices>(),
          get<_i4.CharacterListMapper>(),
          get<_i3.CharacterInfoMapper>(),
        ));
    gh.factory<_i9.LocationListMapper>(
        () => _i9.LocationListMapper(get<_i9.LocationMapper>()));
    gh.factory<_i13.LocationsRepository>(() => _i14.LocationsRepositoryImpl(
          get<_i10.RickMortyServices>(),
          get<_i9.LocationListMapper>(),
        ));
    return this;
  }
}

class _$UseCaseModule extends _i15.UseCaseModule {}

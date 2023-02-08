// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/repositories/characters/characters_repo.dart' as _i9;
import 'package:domain/use_cases/get_character_info_usecase.dart' as _i5;
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'mapper/characters/character_info_mapper.dart' as _i3;
import 'mapper/characters/characters_mappers.dart' as _i4;
import 'repositories/characters/characters_repo_impl.dart' as _i10;
import 'sources/network/graphql/graphql_service.dart' as _i7;
import 'sources/network/rickmorty/rick_morty_services.dart' as _i8;
import 'usecases/usecase_module.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

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
    gh.factory<_i6.GetRickMortyCharactersUseCase>(
        () => useCaseModule.getRickMortyCharactersUseCase);
    gh.singleton<_i7.GraphQLService>(_i7.GraphQLService());
    gh.factory<_i8.RickMortyServices>(
        () => _i8.RickMortyServices(get<_i7.GraphQLService>()));
    gh.factory<_i4.CharacterListMapper>(
        () => _i4.CharacterListMapper(get<_i4.CharacterMapper>()));
    gh.factory<_i9.CharactersRepository>(() => _i10.CharactersRepositoryImpl(
          get<_i8.RickMortyServices>(),
          get<_i4.CharacterListMapper>(),
          get<_i3.CharacterInfoMapper>(),
        ));
    return this;
  }
}

class _$UseCaseModule extends _i11.UseCaseModule {}

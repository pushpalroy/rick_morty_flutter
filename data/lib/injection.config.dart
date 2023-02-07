// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/repositories/characters/characters_repo.dart' as _i15;
import 'package:domain/repositories/jokes/jokes_repository.dart' as _i18;
import 'package:domain/repositories/login_repo.dart' as _i10;
import 'package:domain/use_cases/get_character_info_usecase.dart' as _i5;
import 'package:domain/use_cases/get_five_random_jokes_usecase.dart' as _i6;
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart' as _i7;
import 'package:domain/use_cases/login_use_case.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'mapper/jokes/character_info_mapper.dart' as _i3;
import 'mapper/jokes/characters_mappers.dart' as _i4;
import 'mapper/jokes/jokes_mappers.dart' as _i9;
import 'repositories/characters/characters_repo_impl.dart' as _i16;
import 'repositories/jokes/data_jokes_repository.dart' as _i19;
import 'repositories/pr_login_repo.dart' as _i11;
import 'sources/local/database.dart' as _i13;
import 'sources/network/graphql/graphql_service.dart' as _i8;
import 'sources/network/jokes_api.dart' as _i17;
import 'sources/network/rickmorty/rick_morty_services.dart' as _i14;
import 'usecases/usecase_module.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

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
    gh.factory<_i6.GetFiveRandomJokesUseCase>(
        () => useCaseModule.getJokesUseCase);
    gh.factory<_i7.GetRickMortyCharactersUseCase>(
        () => useCaseModule.getRickMortyCharactersUseCase);
    gh.singleton<_i8.GraphQLService>(_i8.GraphQLService());
    gh.factory<_i9.JokeMapper>(() => _i9.JokeMapper());
    gh.factory<_i9.JokesListMapper>(
        () => _i9.JokesListMapper(get<_i9.JokeMapper>()));
    gh.factory<_i10.LoginRepo>(() => _i11.PraxisLoginRepo());
    gh.factory<_i12.LoginUseCase>(() => useCaseModule.loginUseCase);
    gh.singleton<_i13.PraxisDatabase>(_i13.PraxisDatabase());
    gh.factory<_i14.RickMortyServices>(
        () => _i14.RickMortyServices(get<_i8.GraphQLService>()));
    gh.factory<_i4.CharacterListMapper>(
        () => _i4.CharacterListMapper(get<_i4.CharacterMapper>()));
    gh.factory<_i15.CharactersRepository>(() => _i16.CharactersRepositoryImpl(
          get<_i14.RickMortyServices>(),
          get<_i4.CharacterListMapper>(),
          get<_i3.CharacterInfoMapper>(),
        ));
    gh.factory<_i17.JokesApi>(() => _i17.JokesApi(get<_i9.JokesListMapper>()));
    gh.factory<_i18.JokesRepository>(() => _i19.DataJokesRepository(
          get<_i9.JokesListMapper>(),
          get<_i17.JokesApi>(),
          get<_i13.PraxisDatabase>(),
          get<_i9.JokeMapper>(),
        ));
    return this;
  }
}

class _$UseCaseModule extends _i20.UseCaseModule {}

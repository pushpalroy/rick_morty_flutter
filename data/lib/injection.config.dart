// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/repositories/characters/characters_repo.dart' as _i13;
import 'package:domain/repositories/jokes/jokes_repository.dart' as _i16;
import 'package:domain/repositories/login_repo.dart' as _i8;
import 'package:domain/use_cases/get_five_random_jokes_usecase.dart' as _i4;
import 'package:domain/use_cases/get_rick_morty_characters_usecase.dart' as _i5;
import 'package:domain/use_cases/login_use_case.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'mapper/jokes/characters_mappers.dart' as _i3;
import 'mapper/jokes/jokes_mappers.dart' as _i7;
import 'repositories/characters/characters_repo_impl.dart' as _i14;
import 'repositories/jokes/data_jokes_repository.dart' as _i17;
import 'repositories/pr_login_repo.dart' as _i9;
import 'sources/local/database.dart' as _i11;
import 'sources/network/graphql/graphql_service.dart' as _i6;
import 'sources/network/jokes_api.dart' as _i15;
import 'sources/network/rickmorty/rick_morty_services.dart' as _i12;
import 'usecases/usecase_module.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

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
    gh.factory<_i3.CharacterMapper>(() => _i3.CharacterMapper());
    gh.factory<_i4.GetFiveRandomJokesUseCase>(
        () => useCaseModule.getJokesUseCase);
    gh.factory<_i5.GetRickMortyCharactersUseCase>(
        () => useCaseModule.getRickMortyCharactersUseCase);
    gh.singleton<_i6.GraphQLService>(_i6.GraphQLService());
    gh.factory<_i7.JokeMapper>(() => _i7.JokeMapper());
    gh.factory<_i7.JokesListMapper>(
        () => _i7.JokesListMapper(get<_i7.JokeMapper>()));
    gh.factory<_i8.LoginRepo>(() => _i9.PraxisLoginRepo());
    gh.factory<_i10.LoginUseCase>(() => useCaseModule.loginUseCase);
    gh.singleton<_i11.PraxisDatabase>(_i11.PraxisDatabase());
    gh.factory<_i12.RickMortyServices>(
        () => _i12.RickMortyServices(get<_i6.GraphQLService>()));
    gh.factory<_i3.CharacterListMapper>(
        () => _i3.CharacterListMapper(get<_i3.CharacterMapper>()));
    gh.factory<_i13.CharactersRepository>(() => _i14.CharactersRepositoryImpl(
          get<_i12.RickMortyServices>(),
          get<_i3.CharacterListMapper>(),
        ));
    gh.factory<_i15.JokesApi>(() => _i15.JokesApi(get<_i7.JokesListMapper>()));
    gh.factory<_i16.JokesRepository>(() => _i17.DataJokesRepository(
          get<_i7.JokesListMapper>(),
          get<_i15.JokesApi>(),
          get<_i11.PraxisDatabase>(),
          get<_i7.JokeMapper>(),
        ));
    return this;
  }
}

class _$UseCaseModule extends _i18.UseCaseModule {}

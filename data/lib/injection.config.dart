// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:domain/repositories/jokes/jokes_repository.dart' as _i10;
import 'package:domain/repositories/login_repo.dart' as _i5;
import 'package:domain/use_cases/get_five_random_jokes_usecase.dart' as _i3;
import 'package:domain/use_cases/login_use_case.dart' as _i7;

import 'mapper/jokes/jokes_mappers.dart' as _i4;
import 'repositories/jokes/data_jokes_repository.dart' as _i11;
import 'repositories/pr_login_repo.dart' as _i6;
import 'sources/local/database.dart' as _i8;
import 'sources/network/jokes_api.dart' as _i9;
import 'usecases/usecase_module.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt $initGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final useCaseModule = _$UseCaseModule();
    gh.factory<_i3.GetFiveRandomJokesUseCase>(
        () => useCaseModule.getJokesUseCase);
    gh.factory<_i4.JokeMapper>(() => _i4.JokeMapper());
    gh.factory<_i4.JokesListMapper>(
        () => _i4.JokesListMapper(get<_i4.JokeMapper>()));
    gh.factory<_i5.LoginRepo>(() => _i6.PraxisLoginRepo());
    gh.factory<_i7.LoginUseCase>(() => useCaseModule.loginUseCase);
    gh.singleton<_i8.PraxisDatabase>(_i8.PraxisDatabase());
    gh.factory<_i9.JokesApi>(() => _i9.JokesApi(get<_i4.JokesListMapper>()));
    gh.factory<_i10.JokesRepository>(() => _i11.DataJokesRepository(
        get<_i4.JokesListMapper>(),
        get<_i9.JokesApi>(),
        get<_i8.PraxisDatabase>(),
        get<_i4.JokeMapper>()));
    return this;
  }
}

class _$UseCaseModule extends _i12.UseCaseModule {}

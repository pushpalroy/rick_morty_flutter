// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'infrastructure/notifications/firebase_messaging.dart' as _i3;
import 'ui/model/characters/ui_character_mapper.dart' as _i5;
import 'ui/model/jokes/ui_jokes_mapper.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

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
    gh.factory<_i3.RmFirebaseMessaging>(() => _i3.RmFirebaseMessaging());
    gh.factory<_i4.UIJokeMapper>(() => _i4.UIJokeMapper());
    gh.factory<_i5.UiCharacterMapper>(() => _i5.UiCharacterMapper());
    return this;
  }
}

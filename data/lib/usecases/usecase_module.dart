import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/use_cases/get_five_random_jokes_usecase.dart';
import 'package:domain/use_cases/login_use_case.dart';

@module
abstract class UseCaseModule {
  LoginUseCase get loginUseCase => LoginUseCase(GetIt.instance.get());

  GetFiveRandomJokesUseCase get getJokesUseCase =>
      GetFiveRandomJokesUseCase(GetIt.instance.get());
}

import 'dart:async';

import 'package:clean_architecture/clean_architecture.dart';
import 'package:domain/entities/login_request.dart';
import 'package:domain/entities/login_result.dart';
import 'package:domain/repositories/login_repo.dart';
import 'package:domain/validations.dart';

class LoginUseCase extends UseCase<LoginResult, LoginRequest> {
  final LoginRepo _loginRepo;

  LoginUseCase(this._loginRepo);

  @override
  Future<Stream<LoginResult?>> buildUseCaseStream(LoginRequest? params) async {
    final controller = StreamController<LoginResult>();
    try {
      if (params != null) {
        params.isValid();
        final loginResult =
            await _loginRepo.login(params.email, params.password);
        // Adding it triggers the .onNext() in the `Observer`
        controller.add(loginResult);
        logger.finest('LoginResult successful.');
        controller.close();
      } else {
        logger.severe('LoginRequest is null.');
        controller.addError(InvalidRequestException());
      }
    } catch (e) {
      logger.severe('LoginResult unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

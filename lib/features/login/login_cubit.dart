import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:domain/entities/login_request.dart';
import 'package:domain/entities/login_result.dart';
import 'package:domain/use_cases/login_use_case.dart';

class LoginCubit extends Cubit<UiState<LoginResult>> {
  final loginController = TextEditingController(text: 'random@gmail.com');
  final passwordController = TextEditingController(text: 'random');

  final LoginUseCase loginUseCase = GetIt.instance.get<LoginUseCase>();

  LoginCubit() : super(Initial());

  void login() {
    emit(Loading());
    loginUseCase.perform(
        handleResponse,
        error,
        () {},
        LoginRequest(
            loginController.value.text, passwordController.value.text));
  }

  void handleResponse(LoginResult? response) {
    if (response == null) {
      emit(Failure(exception: Exception("Unexpected error occurred!")));
    } else {
      emit(Success(data: response));
    }
  }

  error(e) {
    emit(Failure(exception: e));
  }

  @override
  Future<void> close() {
    loginUseCase.dispose();
    return super.close();
  }
}

import 'package:equatable/equatable.dart';

class LoginResult extends Equatable {

  final String jwt;
  final String refreshToken;

  const LoginResult(this.jwt, this.refreshToken);

  @override
  List<Object?> get props => [jwt, refreshToken];

}
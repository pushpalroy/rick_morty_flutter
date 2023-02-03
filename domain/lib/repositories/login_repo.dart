import 'package:domain/entities/login_result.dart';

abstract class LoginRepo {
  Future<LoginResult> login(String username, String password);
}

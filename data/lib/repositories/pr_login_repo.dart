import 'package:injectable/injectable.dart';
import 'package:domain/entities/login_result.dart';
import 'package:domain/repositories/login_repo.dart';

@Injectable(as: LoginRepo)
class PraxisLoginRepo extends LoginRepo {
  @override
  Future<LoginResult> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    return const LoginResult("some jwt", "some refresh token");
  }
}

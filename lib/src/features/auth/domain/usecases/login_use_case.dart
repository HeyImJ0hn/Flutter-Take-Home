import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';
import 'package:flutter_take_home/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User> call(String username, String password) async {
    return await _authRepository.login(username, password);
  }
}
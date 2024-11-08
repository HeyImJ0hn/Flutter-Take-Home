import 'package:flutter_take_home/src/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<bool> call() async {
    return _authRepository.logout();
  }
}
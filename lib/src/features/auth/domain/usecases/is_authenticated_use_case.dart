import 'package:flutter_take_home/src/features/auth/domain/repositories/auth_repository.dart';

class IsAuthenticatedUseCase {
  final AuthRepository _authRepository;

  IsAuthenticatedUseCase(this._authRepository);

  Future<bool> call() async {
    return await _authRepository.isAuthenticated();
  }
}
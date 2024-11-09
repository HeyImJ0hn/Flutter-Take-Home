import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/auth/domain/repositories/auth_repository.dart';

class IsAuthenticatedUseCase {
  final AuthRepository _authRepository;

  IsAuthenticatedUseCase(this._authRepository);

  Future<Either<Exception, bool>> call() async {
    return await _authRepository.isAuthenticated();
  }
}
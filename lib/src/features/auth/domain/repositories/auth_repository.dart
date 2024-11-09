import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Exception, User>> login(String username, String password);
  Future<Either<Exception, bool>> logout();
  Future<Either<Exception, bool>> isAuthenticated();
}
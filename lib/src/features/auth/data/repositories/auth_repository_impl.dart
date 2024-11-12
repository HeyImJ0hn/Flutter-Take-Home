import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';
import 'package:flutter_take_home/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource loginDataSource;

  AuthRepositoryImpl(this.loginDataSource);

  @override
  Future<Either<Exception, String>> isAuthenticated() {
    return loginDataSource.isAuthenticated();
  }

  @override
  Future<Either<Exception, User>> login(String username, String password) async {
    final result = await loginDataSource.login(username, password);
    return result.fold(
      (exception) => Left(exception),
      (userModel) => Right(userModel.toEntity())
    );
  }

  @override
  Future<Either<Exception, bool>> logout() {
    return loginDataSource.logout();
  }

}
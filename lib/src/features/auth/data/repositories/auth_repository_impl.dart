import 'package:flutter_take_home/src/features/auth/data/datasources/auth_data_source.dart';
import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';
import 'package:flutter_take_home/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthDataSource loginDataSource;

  AuthRepositoryImpl(this.loginDataSource);

  @override
  Future<bool> isAuthenticated() {
    return loginDataSource.isAuthenticated();
  }

  @override
  Future<User> login(String username, String password) async {
    final userModel = await loginDataSource.login(username, password);
    return userModel.toEntity();
  }

  @override
  Future<bool> logout() {
    return loginDataSource.logout();
  }

}
import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_strings.dart';

abstract class AuthDataSource {
  Future<Either<Exception, String>> isAuthenticated();
  Future<Either<Exception, UserModel>> login(String username, String password);
  Future<Either<Exception, bool>> logout();
}

class AuthDataSourceImpl implements AuthDataSource {

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _usernameKey = 'username';
  
  @override
  Future<Either<Exception, String>> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();  // Numa situação real seria verificado se o token de autenticação é válido
      if (prefs.containsKey(_isLoggedInKey) && prefs.getBool(_isLoggedInKey) == true) {
        return Right(prefs.getString(_usernameKey)!);
      } else {
        return Left(Exception(AppStrings.authDataSourceAuthenticationFailure));
      }
    } catch (e) {
      return Left(Exception(AppStrings.authDataSourceAuthenticationError));
    }
  }

  @override
  Future<Either<Exception, UserModel>> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_usernameKey, username); // Numa situação real seria guardado o token de autenticação

      await Future.delayed(const Duration(seconds: 1)); // Simular autenticação

      return Right(UserModel.fromJson({
          'id': '1',
          'name': username
        })
      );
    } catch (e) {
      await prefs.remove(_usernameKey);
      await prefs.setBool(_isLoggedInKey, false);
      return Left(Exception(AppStrings.authDataSourceLoginError));
    }
  }

  @override
  Future<Either<Exception, bool>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_usernameKey);
      await prefs.setBool(_isLoggedInKey, false);
      return const Right(true);
    } catch (e) {
      return Left(Exception(AppStrings.authDataSourceLogoutError));
    }
  }
}
import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {
  Future<Either<Exception, bool>> isAuthenticated();
  Future<Either<Exception, UserModel>> login(String username, String password);
  Future<Either<Exception, bool>> logout();
}

class AuthDataSourceImpl implements AuthDataSource {

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  
  @override
  Future<Either<Exception, bool>> isAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return Right(prefs.getBool(_isLoggedInKey) ?? false);
    } catch (e) {
      return Left(Exception('Error checking if user is authenticated.'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userIdKey, '1'); // Numa situação real seria guardado o token de autenticação
      return Right(UserModel.fromJson({
          'id': '1',
          'name': 'joao',
          'email': 'joao@jpires.dev',
        })
      );
    } catch (e) {
      await prefs.remove(_userIdKey);
      await prefs.setBool(_isLoggedInKey, false);
      return Left(Exception('Error logging in.'));
    }
  }

  @override
  Future<Either<Exception, bool>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userIdKey);
      await prefs.setBool(_isLoggedInKey, false);
      return const Right(true);
    } catch (e) {
      return Left(Exception('Error logging out.'));
    }
  }
}
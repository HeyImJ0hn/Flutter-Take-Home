import 'package:flutter_take_home/src/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {
  Future<bool> isAuthenticated();
  Future<UserModel> login(String username, String password);
  Future<bool> logout();
}

class AuthDataSourceImpl implements AuthDataSource {

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  
  @override
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  @override
  Future<UserModel> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userIdKey, '1'); // Numa situação real seria guardado o token de autenticação

    try {
      return UserModel.fromJson({
        'id': '1',
        'name': 'joao',
        'email': 'joao@jpires.dev',
      });
    } catch (e) {
      await prefs.remove(_userIdKey);
      await prefs.setBool(_isLoggedInKey, false);
      throw Exception('Error logging in.');
    }
  }

  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.setBool(_isLoggedInKey, false);

    return Future.delayed(const Duration(seconds: 2), () => true);
  }
}
import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<bool> logout();
  Future<bool> isAuthenticated();
}
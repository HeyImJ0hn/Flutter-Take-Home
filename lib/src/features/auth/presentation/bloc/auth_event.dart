part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginButtonPressed extends AuthEvent {
  final String username;
  final String password;

  AuthLoginButtonPressed({
    required this.username,
    required this.password,
  });
}

class AuthLogoutButtonPressed extends AuthEvent {}

class CheckAuthenticationStatus extends AuthEvent {}


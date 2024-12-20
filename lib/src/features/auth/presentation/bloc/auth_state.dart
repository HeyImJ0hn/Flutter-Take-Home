part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({
    required this.user,
  });
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({
    required this.error,
  });
}

final class AuthLogoutSuccess extends AuthState {}

final class AuthLogoutFailure extends AuthState {
  final String error;

  AuthLogoutFailure({
    required this.error,
  });
}

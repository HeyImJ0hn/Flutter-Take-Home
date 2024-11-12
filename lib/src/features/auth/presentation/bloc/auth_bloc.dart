import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_take_home/src/core/constants/app_strings.dart';
import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';
import 'package:flutter_take_home/src/features/auth/domain/usecases/is_authenticated_use_case.dart';
import 'package:flutter_take_home/src/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_take_home/src/features/auth/domain/usecases/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final IsAuthenticatedUseCase isAuthenticatedUseCase;

  AuthBloc(this.loginUseCase, this.logoutUseCase, this.isAuthenticatedUseCase)
      : super(AuthInitial()) {
    on<AuthLoginButtonPressed>(_onLogin);
    on<AuthLogoutButtonPressed>(_onLogout);
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
  }

  Future<void> _onLogin(AuthLoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase.call(event.username, event.password);
    emit(result.fold(
      (exception) => AuthFailure(error: '${AppStrings.authBlocLoginFailure}\n -> ${exception.toString()}'),
      (user) => AuthSuccess(user: user),
    ));
  }

  Future<void> _onLogout(AuthLogoutButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await logoutUseCase.call();
    emit(result.fold(
      (exception) => AuthLogoutFailure(error: '${AppStrings.authBlocLogoutFailure}\n -> ${exception.toString()}'),
      (_) => AuthLogoutSuccess(),
    ));
  }

  Future<void> _onCheckAuthenticationStatus(CheckAuthenticationStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await isAuthenticatedUseCase.call();
    emit(result.fold(
      (exception) => AuthFailure(error: AppStrings.authBlocCheckAuthenticationFailure),
      (username) => AuthSuccess(user: User(id: '1', username: username)),
    ));
  }
}

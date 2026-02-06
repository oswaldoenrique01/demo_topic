import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final GetUserUseCase _getUserUseCase;
  final LogoutUseCase _logoutUseCase;
  StreamSubscription<UserEntity?>? _userSubscription;

  AuthenticationBloc({
    required LoginUseCase loginUseCase,
    required GetUserUseCase getUserUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _loginUseCase = loginUseCase,
       _getUserUseCase = getUserUseCase,
       _logoutUseCase = logoutUseCase,
       super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<AuthenticationLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationLoggedOut>(_onAuthenticationLoggedOut);
    on<AuthenticationLoginRequested>(_onAuthenticationLoginRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  void _onAuthenticationStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) {
    _userSubscription?.cancel();
    _userSubscription = _getUserUseCase().listen((user) {
      if (user != null) {
        add(AuthenticationLoggedIn(user));
      } else {
        add(AuthenticationLoggedOut());
      }
    });
  }

  void _onAuthenticationLoggedIn(
    AuthenticationLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationAuthenticated(event.user));
  }

  void _onAuthenticationLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationUnauthenticated());
  }

  Future<void> _onAuthenticationLoginRequested(
    AuthenticationLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    switch (result) {
      case Success(data: final user):
        emit(AuthenticationAuthenticated(user));
      case Failure(error: final error):
        emit(AuthenticationError(error.message));
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _logoutUseCase();
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

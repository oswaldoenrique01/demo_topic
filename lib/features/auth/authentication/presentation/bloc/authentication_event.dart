part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final UserEntity user;

  const AuthenticationLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

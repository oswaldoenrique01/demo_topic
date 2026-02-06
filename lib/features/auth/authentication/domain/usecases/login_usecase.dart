import 'package:commons/commons.dart';
import 'package:equatable/equatable.dart';
import '../entities/user_entity.dart';
import '../repositories/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository repository;

  LoginUseCase(this.repository);

  Future<Result<UserEntity>> call(LoginParams params) async {
    return await repository.signInWithEmail(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

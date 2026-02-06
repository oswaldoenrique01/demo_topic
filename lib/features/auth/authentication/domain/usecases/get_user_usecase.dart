import '../entities/user_entity.dart';
import '../repositories/authentication_repository.dart';

class GetUserUseCase {
  final AuthenticationRepository repository;

  GetUserUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.user;
  }
}

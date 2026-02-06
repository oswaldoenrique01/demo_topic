import 'package:commons/commons.dart';
import '../repositories/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<void>> call() async {
    return await repository.signOut();
  }
}

import 'package:commons/commons.dart';
import '../entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<Result<UserEntity>> signInWithEmail(String email, String password);
  Future<Result<void>> signOut();
  Stream<UserEntity?> get user;
}

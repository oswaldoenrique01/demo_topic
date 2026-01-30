import 'package:commons/commons.dart';
import '../entities/content_block_entity.dart';
import '../repositories/topics_repository.dart';

class GetTopicsUseCase {
  final TopicsRepository repository;

  GetTopicsUseCase(this.repository);

  Future<Result<List<ContentBlockEntity>>> call() async {
    return await repository.getTopics();
  }
}

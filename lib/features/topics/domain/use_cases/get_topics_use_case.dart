import 'package:commons/commons.dart';
import '../entities/topic_entity.dart';
import '../repositories/topics_repository.dart';

class GetTopicsUseCase {
  final TopicsRepository repository;

  GetTopicsUseCase(this.repository);

  Future<Result<List<TopicEntity>>> call() async {
    return await repository.getTopics();
  }
}

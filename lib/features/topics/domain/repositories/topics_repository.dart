import 'package:commons/commons.dart';
import '../entities/topic_entity.dart';

abstract class TopicsRepository {
  Future<Result<List<TopicEntity>>> getTopics();
}

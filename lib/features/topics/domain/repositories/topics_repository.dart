import 'package:commons/commons.dart';
import '../entities/topic_entity.dart';
import '../entities/topic_detail_entity.dart';

abstract class TopicsRepository {
  Future<Result<List<TopicEntity>>> getTopics();
  Future<Result<TopicDetailEntity>> getTopicDetail(String id);
}

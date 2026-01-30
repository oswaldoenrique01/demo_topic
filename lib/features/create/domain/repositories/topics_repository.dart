import 'package:commons/commons.dart';
import '../entities/content_block_entity.dart';

abstract class TopicsRepository {
  Future<Result<List<ContentBlockEntity>>> getTopics();
}

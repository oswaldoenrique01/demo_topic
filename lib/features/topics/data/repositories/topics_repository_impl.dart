import 'package:commons/commons.dart';
import '../../domain/entities/topic_entity.dart';
import '../../domain/repositories/topics_repository.dart';
import '../datasources/topics_datasource.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  final TopicsRemoteDataSource _remoteDataSource;

  TopicsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<TopicEntity>>> getTopics() async {
    final result = await _remoteDataSource.getTopics();
    return switch (result) {
      Success(data: final data) => Success<List<TopicEntity>>(data),
      Failure(error: final error) => Failure<List<TopicEntity>>(error),
    };
  }
}

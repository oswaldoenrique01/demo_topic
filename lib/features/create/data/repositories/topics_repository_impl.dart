import 'package:commons/commons.dart';
import '../../domain/entities/content_block_entity.dart';
import '../../domain/repositories/topics_repository.dart';
import '../datasources/topics_datasource.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  final TopicsRemoteDataSource _remoteDataSource;

  TopicsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<ContentBlockEntity>>> getTopics() async {
    final result = await _remoteDataSource.getTopics();
    return switch (result) {
      Success(data: final data) => Success<List<ContentBlockEntity>>(data),
      Failure(error: final error) => Failure<List<ContentBlockEntity>>(error),
    };
  }
}

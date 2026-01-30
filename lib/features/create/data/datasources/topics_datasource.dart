import 'package:commons/commons.dart';
import '../models/topic_model.dart';

abstract class TopicsRemoteDataSource {
  Future<Result<List<ContentBlockModel>>> getTopics();
}

class TopicsRemoteDataSourceImpl implements TopicsRemoteDataSource {
  final BaseClient _client;

  TopicsRemoteDataSourceImpl(this._client);

  @override
  Future<Result<List<ContentBlockModel>>> getTopics() async {
    final result = await _client.get('/topics');

    return switch (result) {
      Success(data: final response) => _mapResponse(response),
      Failure(error: final error) => Failure(error),
    };
  }

  Result<List<ContentBlockModel>> _mapResponse(response) {
    try {
      final List<dynamic> data = response.data; // List root in JSON

      final topics = data
          .map((json) => ContentBlockModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(topics);
    } catch (e) {
      return Failure(const UnknownError('Error al parsear topics'));
    }
  }
}

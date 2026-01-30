import 'package:bloc/bloc.dart';
import 'package:commons/commons.dart';
import '../../domain/entities/topic_detail_entity.dart';
import '../../domain/repositories/topics_repository.dart';

// Events
abstract class TopicDetailEvent {}

class GetTopicDetailEvent extends TopicDetailEvent {
  final String id;
  GetTopicDetailEvent(this.id);
}

// States
abstract class TopicDetailState {}

class TopicDetailInitial extends TopicDetailState {}

class TopicDetailLoading extends TopicDetailState {}

class TopicDetailLoaded extends TopicDetailState {
  final TopicDetailEntity topic;
  TopicDetailLoaded(this.topic);
}

class TopicDetailError extends TopicDetailState {
  final String message;
  TopicDetailError(this.message);
}

// Bloc
class TopicDetailBloc extends Bloc<TopicDetailEvent, TopicDetailState> {
  final TopicsRepository _repository;

  TopicDetailBloc(this._repository) : super(TopicDetailInitial()) {
    on<GetTopicDetailEvent>(_onGetTopicDetail);
  }

  Future<void> _onGetTopicDetail(
    GetTopicDetailEvent event,
    Emitter<TopicDetailState> emit,
  ) async {
    emit(TopicDetailLoading());
    final result = await _repository.getTopicDetail(event.id);

    return switch (result) {
      Success(data: final topic) => emit(TopicDetailLoaded(topic)),
      Failure(error: final error) => emit(TopicDetailError(error.toString())),
    };
  }
}

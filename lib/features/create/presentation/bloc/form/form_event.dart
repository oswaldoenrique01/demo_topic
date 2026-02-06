part of 'form_bloc.dart';

sealed class FormCreateEvent extends Equatable {
  const FormCreateEvent();

  @override
  List<Object> get props => [];
}

final class GetFormEvent extends FormCreateEvent {}

final class GetDetailSubtopicEvent extends FormCreateEvent {
  final String topicId;
  final String subtopicId;

  const GetDetailSubtopicEvent(this.topicId, this.subtopicId);

  @override
  List<Object> get props => [
    topicId,
    subtopicId,
  ];

}

final class UpdateDetailEvent extends FormCreateEvent {
  final String topicId;
  final String subtopicId;
  final List<ContentBlockModel> blocks;

  const UpdateDetailEvent(this.topicId, this.subtopicId, this.blocks);

  @override
  List<Object> get props => [
    topicId,
    subtopicId,
    blocks,
  ];

}

final class DeleteBlockDetailEvent extends FormCreateEvent {
  final String topicId;
  final String subtopicId;
  final List<ContentBlockModel> blocks;
  final String blockId;

  const DeleteBlockDetailEvent({
    required this.topicId,
    required this.subtopicId,
    required this.blockId,
    required this.blocks,
  });

  @override
  List<Object> get props => [
    topicId,
    subtopicId,
    blockId,
    blocks,
  ];

}

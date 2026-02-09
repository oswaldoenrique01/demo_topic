import 'package:bloc/bloc.dart';
import 'package:commons/services/exceptions/result.dart';
import 'package:demo_valorant/features/create/domain/use_cases/get_topics_use_case.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/topic_model.dart';
import '../../../domain/entities/content_block_entity.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormCreateBloc extends Bloc<FormCreateEvent, FormCreateState> {
  final GetDetailSubtopicUseCase _useCase;
  FormCreateBloc(this._useCase) : super(FormCreateInitial()) {
    on<GetDetailSubtopicEvent>(_getSubtopicDetail);
    on<UpdateDetailEvent>(_updateDetail);
    on<DeleteBlockDetailEvent>(_deleteBlockDetail);
  }

  Future<void> _getSubtopicDetail(
      GetDetailSubtopicEvent event,
      Emitter<FormCreateState> emit,
  ) async {
    emit(FormCreateLoading());

    final result = await _useCase(event.topicId, event.subtopicId);

    switch (result) {
      case Success(data: final topics):
        emit(FormCreateSuccess(topics));
        break;
      case Failure(error: final error):
        emit(FormCreateError(error.message));
        break;
    }
  }

  Future<void> _updateDetail(
      UpdateDetailEvent event,
      Emitter<FormCreateState> emit,
  ) async {
    emit(FormCreateLoading());

    await _useCase.update(
      event.topicId,
      event.subtopicId,
      event.blocks,
    );

    // 👉 dispara nuevo evento
    add(GetDetailSubtopicEvent(
      event.topicId,
      event.subtopicId,
    ));
  }

  Future<void> _deleteBlockDetail(
      DeleteBlockDetailEvent event,
      Emitter<FormCreateState> emit,
      ) async {

    // final result = await _useCase.deleteBlock(
    await _useCase.deleteBlock(
      event.topicId,
      event.subtopicId,
      event.blockId,
    );

    // switch (result) {
    //   case Success(data: final _):
    //     emit(FormCreateSuccess(event.blocks));
    //     break;
    //   case Failure(error: final error):
    //     emit(FormCreateError(error.message));
    //     break;
    // }
  }
}

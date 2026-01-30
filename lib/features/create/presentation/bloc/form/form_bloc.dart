import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/content_block_entity.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormCreateBloc extends Bloc<FormCreateEvent, FormCreateState> {

  FormCreateBloc() : super(FormCreateInitial()) {
    on<GetFormEvent>(_onGetTopics);
  }

  Future<void> _onGetTopics(
    GetFormEvent event,
    Emitter<FormCreateState> emit,
  ) async {
    emit(FormCreateLoading());

  }
}

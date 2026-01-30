part of 'form_bloc.dart';

sealed class FormCreateState extends Equatable {
  const FormCreateState();

  @override
  List<Object> get props => [];
}

final class FormCreateInitial extends FormCreateState {}

final class FormCreateLoading extends FormCreateState {}

final class FormCreateSuccess extends FormCreateState {
  final List<ContentBlockEntity> topics;

  const FormCreateSuccess(this.topics);

  @override
  List<Object> get props => [topics];
}

final class FormCreateError extends FormCreateState {
  final String message;

  const FormCreateError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'form_bloc.dart';

sealed class FormCreateEvent extends Equatable {
  const FormCreateEvent();

  @override
  List<Object> get props => [];
}

final class GetFormEvent extends FormCreateEvent {}

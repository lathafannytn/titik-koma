part of 'event_data_bloc.dart';

abstract class EventDataBlocState extends Equatable {
  const EventDataBlocState();

  @override
  List<Object> get props => [];
}

class EventDataBlocInitial extends EventDataBlocState {}

class EventDataBlocLoading extends EventDataBlocState {}

class EventDataBlocSuccess extends EventDataBlocState {
  final String message;

  const EventDataBlocSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'EventDataBlocSuccess { message: $message }';
}

class EventDataBlocFailure extends EventDataBlocState {
  final String error;
  final String message;

  const EventDataBlocFailure({required this.error,required this.message});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventDataBlocFailure { error: $error , message : $message }';
}

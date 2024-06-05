part of 'event_data_bloc.dart';

abstract class EventDataBlocEvent extends Equatable {
  const EventDataBlocEvent();

  @override
  List<Object> get props => [];
}

class EventDataBlocButtonPressed extends EventDataBlocEvent {
  final String event;

  const EventDataBlocButtonPressed({
    required this.event
  });

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'EventDataButtonPressed { event: $event, }';
}

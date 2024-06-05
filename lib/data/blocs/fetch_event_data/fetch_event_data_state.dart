import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/event_data.dart';

abstract class EventDataState extends Equatable {
  const EventDataState();

  @override
  List<Object> get props => [];
}

class EventDataInitial extends EventDataState {}

class EventDataLoading extends EventDataState {}

class EventDataSuccess extends EventDataState {
  EventDataSuccess(this.eventData);

  final List<EventData> eventData;

  @override
  List<Object> get props => [eventData];
}

class EventDataSuccessDetail extends EventDataState {
  EventDataSuccessDetail(this.eventData);

  final EventData eventData;

  @override
  List<Object> get props => [eventData];
}

class EventDataFailure extends EventDataState {
  final String message;

  EventDataFailure(this.message);

  @override
  List<Object> get props => [message];
}

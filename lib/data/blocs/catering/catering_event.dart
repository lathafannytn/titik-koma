part of 'catering_bloc.dart';

abstract class CateringBlocEvent extends Equatable {
  const CateringBlocEvent();

  @override
  List<Object> get props => [];
}

class CateringBlocButtonPressed extends CateringBlocEvent {
  final String event;

  const CateringBlocButtonPressed({
    required this.event
  });

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'CateringButtonPressed { event: $event, }';
}

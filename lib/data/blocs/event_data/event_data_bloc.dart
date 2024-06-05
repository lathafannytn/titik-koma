import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tikom/data/repository/event_data_repository.dart';

part 'event_data_event.dart';
part 'event_data_state.dart';

class EventDataBloc extends Bloc<EventDataBlocEvent, EventDataBlocState> {
  EventDataBloc() : super(EventDataBlocInitial()) {
    on<EventDataBlocEvent>(onEventDataEvent);
  }

  final EventDataRepository eventDataRepository = EventDataRepository();

  void onEventDataEvent(
      EventDataBlocEvent event, Emitter<EventDataBlocState> emit) async {
    if (event is EventDataBlocButtonPressed) {
      print('masuk');

      emit(EventDataBlocLoading());
      try {
        final eventDataResponse = await eventDataRepository.store(
          event: event.event,
        );
        print('masuk');
        print(eventDataResponse.message);
        print('disini');
        if (eventDataResponse.status == 'success') {
          emit(EventDataBlocSuccess(message: eventDataResponse.message));
        } else {
          emit(EventDataBlocFailure(
              message: eventDataResponse.message,
              error: 'Not Server' ?? 'Unknown error'));
        }
      } catch (error) {
        print(error);
        emit(EventDataBlocFailure(
            message: 'Server Error ', error: error.toString()));
      }
    }
  }
}

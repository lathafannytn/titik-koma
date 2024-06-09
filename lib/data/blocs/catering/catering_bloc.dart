import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tikom/data/repository/event_data_repository.dart';
import 'package:tikom/data/repository/full_service_repository.dart';

part 'catering_event.dart';
part 'catering_state.dart';

class CateringBloc extends Bloc<CateringBlocEvent, CateringBlocState> {
  CateringBloc() : super(CateringBlocInitial()) {
    on<CateringBlocEvent>(onCateringEvent);
  }

  final FullServiceRepository _fullServiceRepository = FullServiceRepository();

  void onCateringEvent(
      CateringBlocEvent event, Emitter<CateringBlocState> emit) async {
    if (event is CateringBlocButtonPressed) {
      print('masuk');

      emit(CateringBlocLoading());
      try {
        print(event);
        // final CateringResponse = await CateringRepository.store(
        //   event: event.event,
        // );
        // print('masuk');
        // print(CateringResponse.message);
        // print('disini');
        // if (CateringResponse.status == 'success') {
        //   emit(CateringBlocSuccess(message: CateringResponse.message));
        // } else {
        //   emit(CateringBlocFailure(
        //       message: CateringResponse.message,
        //       error: 'Not Server' ?? 'Unknown error'));
        // }
      } catch (error) {
        print(error);
        emit(CateringBlocFailure(
            message: 'Server Error ', error: error.toString()));
      }
    }
  }
}

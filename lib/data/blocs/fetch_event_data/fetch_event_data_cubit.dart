import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_event_data/fetch_event_data_state.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_state.dart';
import 'package:tikom/data/repository/event_data_repository.dart';
import 'package:tikom/data/repository/my_voucher_repository.dart';

class EventDataCubit extends Cubit<EventDataState> {
  EventDataCubit([eventRepository]) : super(EventDataInitial());

  final EventDataRepository _EventDataRepository = EventDataRepository();

  Future<void> loadEventData() async {
    emit(EventDataLoading());
    print('Ini Load Event');
    try {
      final response = await _EventDataRepository.data();
      print(response.data);
      emit(EventDataSuccess(response.data));
    } catch (error) {
      emit(EventDataFailure(error.toString()));
    }
  }

  Future<void> loadEventDataLimit() async {
    emit(EventDataLoading());
    print('Ini Load Event Limit');
    try {
      final response = await _EventDataRepository.dataLimit();
      print(response.data);
      emit(EventDataSuccess(response.data));
    } catch (error) {
      emit(EventDataFailure(error.toString()));
    }
  }

  Future<void> loadEventDetailData(String uuid) async {
    emit(EventDataLoading());
    print('From Cubit');
    try {
      final response = await _EventDataRepository.showDetail(uuid: uuid);
      print('From Cubit');
      print(response);
      emit(EventDataSuccessDetail(response.data));
    } catch (error) {
      print(error.toString());
      emit(EventDataFailure(error.toString()));
    }
  }

  Future<void> loadMyEventData() async {
    emit(EventDataLoading());
    print('Ini Load My Event');
    try {
      final response = await _EventDataRepository.myEvent();
      print(response.data);
      emit(EventDataSuccess(response.data));
    } catch (error) {
      emit(EventDataFailure(error.toString()));
    }
  }

    Future<void> loadMyEventDetailData(String uuid) async {
    emit(EventDataLoading());
    print('From Cubit');
    try {
      final response = await _EventDataRepository.showMyEventDetail(uuid: uuid);
      print('From Cubit');
      print(response);
      emit(EventDataSuccessDetail(response.data));
    } catch (error) {
      print(error.toString());
      emit(EventDataFailure(error.toString()));
    }
  }
}

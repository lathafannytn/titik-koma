import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_full_service/full_service_state.dart';
import 'package:tikom/data/repository/full_service_repository.dart';

class FullServiceCubit extends Cubit<FullServiceState> {
  FullServiceCubit() : super(FullServiceInitial());

  final FullServiceRepository _fullServiceRepository = FullServiceRepository();

  Future<void> loadFullService() async {
    emit(FullServiceLoading());
    print('hallo');
    try {
      print('hallo');
      final response = await _fullServiceRepository.showFullService();
      print(response);
      print('masuk sini');
      emit(FullServiceSuccess(response.data));
    } catch (error) {
      print('errornih ');
      print(error);
      emit(FullServiceFailure(error.toString()));
    }
  }
}

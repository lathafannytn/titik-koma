import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_bundle/fetch_bundle_state.dart';
import 'package:tikom/data/repository/full_service_cafe_repository.dart';


class BundleCubit extends Cubit<BundleState> {
  BundleCubit([eventRepository]) : super(BundleInitial());

  final FullServiceCafeRepository _fullServiceCafeRepository  = FullServiceCafeRepository ();

  Future<void> loadBundle() async {
    emit(BundleLoading());
    print('Ini Load bundle');
    try {
      final response = await _fullServiceCafeRepository.showBundle();
      print(response.data);
      emit(BundleSuccess(response.data));
    } catch (error) {
      emit(BundleFailure(error.toString()));
    }
  }

  Future<void> loadBundleProduct(dynamic bundle_id) async {
    emit(BundleLoading());
    print('Ini Load Bundle Product');
    try {
      final response = await _fullServiceCafeRepository.showBundleProduct(bundle_id);
      print(response.data);
      emit(BundleSuccess(response.data));
    } catch (error) {
      emit(BundleFailure(error.toString()));
    }
  }


}

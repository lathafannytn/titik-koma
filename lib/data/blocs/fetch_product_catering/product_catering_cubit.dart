import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_full_service/full_service_state.dart';
import 'package:tikom/data/blocs/fetch_product_catering/product_catering_state.dart';
import 'package:tikom/data/repository/full_service_repository.dart';

class ProductCateringCubit extends Cubit<ProductCateringState> {
  ProductCateringCubit() : super(ProductCateringInitial());

  final FullServiceRepository _fullServiceRepository = FullServiceRepository();

  Future<void> loadProductCatering() async {
    emit(ProductCateringLoading());
    print('hallo');
    try {
      print('hallo');
      final response = await _fullServiceRepository.showProductFullService();
      print(response);
      print('masuk sini');
      emit(ProductCateringSuccess(response.drinks));
    } catch (error) {
      print('errornih ');
      print(error);
      emit(ProductCateringFailure(error.toString()));
    }
  }
}

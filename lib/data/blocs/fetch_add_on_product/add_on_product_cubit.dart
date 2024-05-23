import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/blocs/fetch_add_on_product/add_on_product_state.dart';

import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/repository/product_repository.dart';

class AddOnProductDataCubit extends Cubit<AddOnProductDataState> {
  AddOnProductDataCubit() : super(AddOnProductDataInitial());

  final ProductDetailRepository _productDetailRepository =
      ProductDetailRepository();

  Future<void> loadCupSizeData() async {
    emit(AddOnProductDataLoading());
    print('hallo');
    try {
      print('hallo');
      final response = await _productDetailRepository.addOnProductCupSize();
      print(response.data);
      emit(AddOnProductDataSuccess(response.data));
    } catch (error) {
      emit(AddOnProductDataFailure(error.toString()));
    }
  }

  Future<void> loadIceLevelData() async {
      emit(AddOnProductIceLevelDataLoading());
      print('hallo');
      try {
        print('hallo');
        final response = await _productDetailRepository.addOnProductIceLevel();
        print(response.data);
        emit(AddOnProductIceLevelDataSuccess(response.data));
      } catch (error) {
        emit(AddOnProductIceLevelDataFailure(error.toString()));
      }
  }


  Future<void> loadSugarData() async {
      emit(AddOnProductSugarDataLoading());
      print('hallo');
      try {
        print('hallo');
        final response = await _productDetailRepository.addOnProductSugar();
        print(response.data);
        emit(AddOnProductSugarDataSuccess(response.data));
      } catch (error) {
        emit(AddOnProductSugarDataFailure(error.toString()));
      }
  }


}

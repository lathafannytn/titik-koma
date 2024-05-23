import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';
import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/repository/product_repository.dart';

class ProductDetailDataCubit extends Cubit<ProductDetailDataState> {
  ProductDetailDataCubit() : super(ProductDetailDataInitial());

  final ProductDetailRepository _productDetailRepository =
      ProductDetailRepository();

  Future<void> loadProductDetailData(String uuid) async {
    emit(ProductDetailDataLoading());
    print('From Cubit');
    try {
      final response = await _productDetailRepository.showDetail(uuid: uuid);
      print('From Cubit');
      print(response);
      if (response != null && response.data != null) {
        print('hm');
        print(response.data!);
        // final productDetail =
        //     ProductDetail.fromJson(response.data as Map<String, dynamic>);
        emit(ProductDetailDataLoaded(response.data!));
      } else {
        emit(ProductDetailDataError('Data Is NUll'));
      }
    } catch (error) {
      print(error.toString());
      emit(ProductDetailDataError(error.toString()));
    }
  }
}

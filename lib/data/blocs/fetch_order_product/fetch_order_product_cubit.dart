import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/data/blocs/fetch_order_product/fetch_order_product_state.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';
import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/repository/order_repository.dart';
import 'package:tikom/data/repository/product_repository.dart';

class OrderProductCubit extends Cubit<OrderProductState> {
  OrderProductCubit() : super(OrderProductInitial());

  final OrderRepository _OrderRepository = OrderRepository();

  Future<void> loadOrderProduct() async {
    emit(OrderProductLoading());
    print('hallo');
    try {
      print('hallo');
      final response = await _OrderRepository.showOrderProduct();
      print(response);
      print('masuk sini');
      emit(OrderProductSuccess(response.order));
    } catch (error) {
      print('errornih ');
      print(error);
      emit(OrderProductFailure(error.toString()));
    }
  }
}

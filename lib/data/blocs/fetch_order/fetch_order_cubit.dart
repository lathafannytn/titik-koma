import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';
import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/repository/order_repository.dart';
import 'package:tikom/data/repository/product_repository.dart';

class OrderDataCubit extends Cubit<OrderDataState> {
  OrderDataCubit() : super(OrderDataInitial());

  final OrderRepository _OrderRepository =
      OrderRepository();


   Future<void> loadOrderData() async {
    emit(OrderDataLoading());
    print('hallo');
    try {
      print('hallo');
      final response = await await _OrderRepository.showOrder();
      print(response.data);
      emit(OrderDataSuccess(response.data));
    } catch (error) {
      emit(OrderDataFailure(error.toString()));
    }
  }
}

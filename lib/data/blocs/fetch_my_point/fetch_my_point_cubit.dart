import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_my_point/fetch_my_point_state.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_state.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';
import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/repository/my_voucher_repository.dart';
import 'package:tikom/data/repository/order_repository.dart';
import 'package:tikom/data/repository/product_repository.dart';
import 'package:tikom/data/repository/user_repository.dart';

class PointHistoryCubit extends Cubit<PointHistoryState> {
  PointHistoryCubit() : super(PointHistoryInitial());

  final UserRepository _userRepository = UserRepository();


   Future<void> loadPointHistory() async {
    emit(PointHistoryLoading());
    print('Ini Load Voucher');
    try {
      print('Ini Load Voucher In Try');
      final response = await await _userRepository.fetchMyPoint();
      print(response.data);
      emit(PointHistorySuccess(response.data));
    } catch (error) {
      emit(PointHistoryFailure(error.toString()));
    }
  }
}

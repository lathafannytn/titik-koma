import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_my_voucher/fetch_my_voucher_state.dart';
import 'package:tikom/data/blocs/fetch_order/fetch_order_state.dart';
import 'package:tikom/data/blocs/fetch_product_detail/product_detail_state.dart';
import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/repository/my_voucher_repository.dart';
import 'package:tikom/data/repository/order_repository.dart';
import 'package:tikom/data/repository/product_repository.dart';

class MyVoucherCubit extends Cubit<MyVoucherState> {
  MyVoucherCubit() : super(MyVoucherInitial());

  final MyVoucherRepository _MyVoucherRepository = MyVoucherRepository();


   Future<void> loadMyVoucher() async {
    emit(MyVoucherLoading());
    print('Ini Load Voucher');
    try {
      print('Ini Load Voucher In Try');
      final response = await await _MyVoucherRepository.fetchVoucher();
      print(response.data);
      emit(MyVoucherSuccess(response.data));
    } catch (error) {
      emit(MyVoucherFailure(error.toString()));
    }
  }
}

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/fetch_voucher/vocuher_state.dart';

import 'package:tikom/data/repository/voucher_repository.dart';

class VoucherDataCubit extends Cubit<VoucherDataState> {
  VoucherDataCubit() : super(VoucherDataInitial());

  final VoucherRepository _voucherRepository = VoucherRepository();

  Future<void> loadVoucherData() async {
    emit(VoucherDataLoading());
    print('From Cubit');
    try {
      final response = await _voucherRepository.fetchVoucher();
      print('From Cubit');
      print(response);
      if (response != null && response.data != null) {
        print('hm nih');
        print(response.data!);
        emit(VoucherDataSuccess(response.data));
      } else {
        emit(VoucherDataError('Data Is NUll'));
      }
    } catch (error) {
      print('form this');
      print(error.toString());
      emit(VoucherDataError(error.toString()));
    }
  }
}

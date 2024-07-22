import 'package:tikom/data/models/my_voucher.dart';
import 'package:tikom/data/models/voucher.dart';

class VoucherDataState {}

class VoucherDataInitial extends VoucherDataState {}

class VoucherDataLoading extends VoucherDataState {}

class VoucherDataLoaded extends VoucherDataState {
  final List<MyVoucher> voucher;
  VoucherDataLoaded(this.voucher);
}


class VoucherDataSuccess extends VoucherDataState {
  VoucherDataSuccess(this.voucher);

  final List<Voucher> voucher;

  @override
  List<Object> get props => [voucher];
}

class VoucherDataError extends VoucherDataState {
  final String message;
  VoucherDataError(this.message);
}

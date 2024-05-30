import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/my_voucher.dart';
import 'package:tikom/data/models/order.dart';

abstract class MyVoucherState extends Equatable {
  const MyVoucherState();

  @override
  List<Object> get props => [];
}

class MyVoucherInitial extends MyVoucherState {}

class MyVoucherLoading extends MyVoucherState {}

class MyVoucherSuccess extends MyVoucherState {
  MyVoucherSuccess(this.voucher);

  final List<MyVoucher> voucher;

  @override
  List<Object> get props => [voucher];
}

class MyVoucherFailure extends MyVoucherState {
  final String message;

  MyVoucherFailure(this.message);

  @override
  List<Object> get props => [message];
}

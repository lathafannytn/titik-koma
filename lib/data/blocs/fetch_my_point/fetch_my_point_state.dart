import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/my_voucher.dart';
import 'package:tikom/data/models/order.dart';
import 'package:tikom/data/models/point_history.dart';

abstract class PointHistoryState extends Equatable {
  const PointHistoryState();

  @override
  List<Object> get props => [];
}

class PointHistoryInitial extends PointHistoryState {}

class PointHistoryLoading extends PointHistoryState {}

class PointHistorySuccess extends PointHistoryState {
  PointHistorySuccess(this.voucher);

  final List<PointHistory> voucher;

  @override
  List<Object> get props => [voucher];
}

class PointHistoryFailure extends PointHistoryState {
  final String message;

  PointHistoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

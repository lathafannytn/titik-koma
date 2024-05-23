import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/order.dart';

abstract class OrderDataState extends Equatable {
  const OrderDataState();

  @override
  List<Object> get props => [];
}

class OrderDataInitial extends OrderDataState {}

class OrderDataLoading extends OrderDataState {}

class OrderDataSuccess extends OrderDataState {
  OrderDataSuccess(this.categories);

  final List<OrderData> categories;

  @override
  List<Object> get props => [categories];
}

class OrderDataFailure extends OrderDataState {
  final String message;

  OrderDataFailure(this.message);

  @override
  List<Object> get props => [message];
}

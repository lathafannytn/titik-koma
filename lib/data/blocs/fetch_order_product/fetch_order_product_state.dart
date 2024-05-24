import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/order.dart';
import 'package:tikom/data/models/order_product.dart';

abstract class OrderProductState extends Equatable {
  const OrderProductState();

  @override
  List<Object> get props => [];
}

class OrderProductInitial extends OrderProductState {}

class OrderProductLoading extends OrderProductState {}

class OrderProductSuccess extends OrderProductState {
  OrderProductSuccess(this.order);

  final List<OrderProduct> order;

  @override
  List<Object> get props => [order];
}

class OrderProductFailure extends OrderProductState {
  final String message;

  OrderProductFailure(this.message);

  @override
  List<Object> get props => [message];
}

part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String message;

  const OrderSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Order Success { message: $message }';
}

class OrderFailure extends OrderState {
  final String error;
  final String message;

  const OrderFailure({required this.error,required this.message});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error , message : $message }';
}

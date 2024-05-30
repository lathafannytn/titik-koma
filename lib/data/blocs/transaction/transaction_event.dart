part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionButtonPressed extends TransactionEvent {
  final int price;
  final String payment_type;
  final String voucher;
  final String use_point;

  const TransactionButtonPressed({
    required this.price,
    required this.payment_type,
    required this.voucher,
    required this.use_point,
  });

  @override
  List<Object> get props => [price,payment_type,voucher,use_point];

  @override
  String toString() => 'TransactionButtonPressed { price: $price, }';
}




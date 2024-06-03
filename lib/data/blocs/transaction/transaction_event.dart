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
  final String service_date;


  const TransactionButtonPressed({
    required this.price,
    required this.payment_type,
    required this.voucher,
    required this.use_point,
    required this.service_date
  });

  @override
  List<Object> get props => [price,payment_type,voucher,use_point];

  @override
  String toString() => 'TransactionButtonPressed { price: $price, }';
}


abstract class TransactionPaymentEvent extends Equatable {
  const TransactionPaymentEvent();

  @override
  List<Object> get props => [];
}


class TransactionPaymentButtonPressed extends TransactionPaymentEvent {
  final String uuid;
  final String image;


  const TransactionPaymentButtonPressed({
    required this.uuid,
    required this.image,
  });

  @override
  List<Object> get props => [uuid,image];

  @override
  String toString() => 'TransactionPaymentButtonPressed { UUID: $uuid, }';
}




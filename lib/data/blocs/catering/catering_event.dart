part of 'catering_bloc.dart';

abstract class CateringBlocEvent extends Equatable {
  const CateringBlocEvent();

  @override
  List<Object> get props => [];
}

class CateringBlocButtonPressed extends CateringBlocEvent {
  final String price;
  final String custom_cup_name;
  final String custom_cup_note;
  final String base_delivery;
  final String products;
  final dynamic delivery_address;
  final dynamic delivery_price;
  final String payment_type;
  final String voucher;
  final String use_point;
  final List<String> add_on;

  const CateringBlocButtonPressed({
    required this.price,
    required this.custom_cup_name,
    required this.custom_cup_note,
    required this.base_delivery,
    required this.products,
    required this.delivery_address,
    required this.delivery_price,
    required this.payment_type,
    required this.voucher,
    required this.use_point,
    required this.add_on
  });

  @override
  List<Object> get props => [price,custom_cup_name,base_delivery,products,delivery_address,delivery_price,payment_type,voucher,use_point];

  @override
  String toString() => 'CateringButtonPressed { price: $price, }';
}

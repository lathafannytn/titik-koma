part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderButtonPressed extends OrderEvent {
  final List<String>  products;
  final String selected;
  final List<String> add_on;
  final double total;

  const OrderButtonPressed({
    required this.products,
    required this.selected,
    required this.add_on,
    required this.total,
  });

  @override
  List<Object> get props => [products,selected,add_on,total];

  @override
  String toString() => 'OrderButtonPressed { products: $products, }';
}

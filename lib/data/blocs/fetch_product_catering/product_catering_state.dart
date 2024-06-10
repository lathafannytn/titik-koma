import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/drinks.dart';
import 'package:tikom/data/models/full_service.dart';


abstract class ProductCateringState extends Equatable {
  const ProductCateringState();

  @override
  List<Object> get props => [];
}

class ProductCateringInitial extends ProductCateringState {}

class ProductCateringLoading extends ProductCateringState {}

class ProductCateringSuccess extends ProductCateringState {
  ProductCateringSuccess(this.drinks);

  final List<Drinks> drinks;

  @override
  List<Object> get props => [drinks];
}

class ProductCateringFailure extends ProductCateringState {
  final String message;

  ProductCateringFailure(this.message);

  @override
  List<Object> get props => [message];
}

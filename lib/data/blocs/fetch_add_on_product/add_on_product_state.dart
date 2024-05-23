import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/add_on_product.dart';

abstract class AddOnProductDataState extends Equatable {
  const AddOnProductDataState();

  @override
  List<Object> get props => [];
}

class AddOnProductDataInitial extends AddOnProductDataState {}

class AddOnProductDataLoading extends AddOnProductDataState {}

class AddOnProductDataSuccess extends AddOnProductDataState {
  AddOnProductDataSuccess(this.categories);

  final List<AddOnProduct> categories;

  @override
  List<Object> get props => [categories];
}

class AddOnProductDataFailure extends AddOnProductDataState {
  final String message;

  AddOnProductDataFailure(this.message);

  @override
  List<Object> get props => [message];
}


class AddOnProductIceLevelDataInitial extends AddOnProductDataState {}

class AddOnProductIceLevelDataLoading extends AddOnProductDataState {}

class AddOnProductIceLevelDataSuccess extends AddOnProductDataState {
  AddOnProductIceLevelDataSuccess(this.categories);

  final List<AddOnProduct> categories;

  @override
  List<Object> get props => [categories];
}

class AddOnProductIceLevelDataFailure extends AddOnProductDataState {
  final String message;

  AddOnProductIceLevelDataFailure(this.message);

  @override
  List<Object> get props => [message];
}


class AddOnProductSugarDataInitial extends AddOnProductDataState {}

class AddOnProductSugarDataLoading extends AddOnProductDataState {}

class AddOnProductSugarDataSuccess extends AddOnProductDataState {
  AddOnProductSugarDataSuccess(this.categories);

  final List<AddOnProduct> categories;

  @override
  List<Object> get props => [categories];
}

class AddOnProductSugarDataFailure extends AddOnProductDataState {
  final String message;

  AddOnProductSugarDataFailure(this.message);

  @override
  List<Object> get props => [message];
}
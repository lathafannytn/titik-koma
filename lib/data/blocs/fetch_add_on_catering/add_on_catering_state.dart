import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/add_on_catering.dart';


abstract class AddOnCateringDataState extends Equatable {
  const AddOnCateringDataState();

  @override
  List<Object> get props => [];
}

class AddOnCateringDataInitial extends AddOnCateringDataState {}

class AddOnCateringDataLoading extends AddOnCateringDataState {}

class AddOnCateringDataSuccess extends AddOnCateringDataState {
  AddOnCateringDataSuccess(this.data);

  final List<AddOnCatering> data;

  @override
  List<Object> get props => [data];
}

class AddOnCateringDataFailure extends AddOnCateringDataState {
  final String message;

  AddOnCateringDataFailure(this.message);

  @override
  List<Object> get props => [message];
}


class AddOnCateringIceLevelDataInitial extends AddOnCateringDataState {}

class AddOnCateringIceLevelDataLoading extends AddOnCateringDataState {}

class AddOnCateringIceLevelDataSuccess extends AddOnCateringDataState {
  AddOnCateringIceLevelDataSuccess(this.categories);

  final List<AddOnCatering> categories;

  @override
  List<Object> get props => [categories];
}

class AddOnCateringIceLevelDataFailure extends AddOnCateringDataState {
  final String message;

  AddOnCateringIceLevelDataFailure(this.message);

  @override
  List<Object> get props => [message];
}


class AddOnCateringSugarDataInitial extends AddOnCateringDataState {}

class AddOnCateringSugarDataLoading extends AddOnCateringDataState {}

class AddOnCateringSugarDataSuccess extends AddOnCateringDataState {
  AddOnCateringSugarDataSuccess(this.categories);

  final List<AddOnCatering> categories;

  @override
  List<Object> get props => [categories];
}

class AddOnCateringSugarDataFailure extends AddOnCateringDataState {
  final String message;

  AddOnCateringSugarDataFailure(this.message);

  @override
  List<Object> get props => [message];
}
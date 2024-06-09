import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/full_service.dart';


abstract class FullServiceState extends Equatable {
  const FullServiceState();

  @override
  List<Object> get props => [];
}

class FullServiceInitial extends FullServiceState {}

class FullServiceLoading extends FullServiceState {}

class FullServiceSuccess extends FullServiceState {
  FullServiceSuccess(this.full_service);

  final List<FullService> full_service;

  @override
  List<Object> get props => [full_service];
}

class FullServiceFailure extends FullServiceState {
  final String message;

  FullServiceFailure(this.message);

  @override
  List<Object> get props => [message];
}

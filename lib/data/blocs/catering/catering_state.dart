part of 'catering_bloc.dart';

abstract class CateringBlocState extends Equatable {
  const CateringBlocState();

  @override
  List<Object> get props => [];
}

class CateringBlocInitial extends CateringBlocState {}

class CateringBlocLoading extends CateringBlocState {}

class CateringBlocSuccess extends CateringBlocState {
  final String message;

  const CateringBlocSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'CateringBlocSuccess { message: $message }';
}

class CateringBlocFailure extends CateringBlocState {
  final String error;
  final String message;

  const CateringBlocFailure({required this.error,required this.message});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CateringBlocFailure { error: $error , message : $message }';
}

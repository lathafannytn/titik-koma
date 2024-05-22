part of 'sign_in_email_bloc.dart';

abstract class SignInEmailState extends Equatable {
  const SignInEmailState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInEmailState {}

class SignInLoading extends SignInEmailState {}

class SignInSuccess extends SignInEmailState {
  final String message;

  const SignInSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'LoginSuccess { message: $message }';
}

class SignInFailure extends SignInEmailState {
  final String error;
  final String message;

  const SignInFailure({required this.error,required this.message});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error , message : $message }';
}

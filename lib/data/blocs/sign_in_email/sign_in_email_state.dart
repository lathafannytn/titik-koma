part of 'sign_in_email_bloc.dart';

abstract class SignInEmailState extends Equatable {
  const SignInEmailState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInEmailState {}

class SignInLoading extends SignInEmailState {}

class SignInSuccess extends SignInEmailState {}

class SignInFailure extends SignInEmailState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

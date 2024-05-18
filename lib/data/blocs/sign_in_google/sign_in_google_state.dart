part of 'sign_in_google_bloc.dart';

abstract class SignInGoogleState extends Equatable {
  const SignInGoogleState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInGoogleState {}

class SignInLoading extends SignInGoogleState {}


class SignInFailure extends SignInGoogleState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

part of 'sign_in_otp_bloc.dart';

abstract class SignInEmailOtpState extends Equatable {
  const SignInEmailOtpState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInEmailOtpState {}

class SignInLoading extends SignInEmailOtpState {}


class SignInSuccess extends SignInEmailOtpState {}

class SignInFailure extends SignInEmailOtpState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

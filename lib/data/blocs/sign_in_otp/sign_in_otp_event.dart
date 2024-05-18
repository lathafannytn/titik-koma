part of 'sign_in_otp_bloc.dart';

abstract class SignInEmailOtpEvent extends Equatable {
  const SignInEmailOtpEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends SignInEmailOtpEvent {
  final String email;
  final String otp;

  const SignInButtonPressed({
    required this.email,
    required this.otp,
  });

  @override
  List<Object> get props => [email,otp];

  @override
  String toString() => 'SignInButtonPressed { email: $email, }';
}

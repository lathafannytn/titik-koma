part of 'sign_in_google_bloc.dart';

abstract class SignInGoogleEvent extends Equatable {
  const SignInGoogleEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends SignInGoogleEvent {
  final String email;
  final String password;

  const SignInButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email,password];

  @override
  String toString() => 'SignInButtonPressed { email: $email, }';
}

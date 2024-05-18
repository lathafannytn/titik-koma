part of 'sign_in_email_bloc.dart';

abstract class SignInEmailEvent extends Equatable {
  const SignInEmailEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends SignInEmailEvent {
  final String email;

  const SignInButtonPressed({
    required this.email,
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SignInButtonPressed { email: $email, }';
}

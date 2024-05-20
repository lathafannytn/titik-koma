part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String name;
  final String phone;
  final String bornDate;
  final String address;




  const SignUpButtonPressed({
    required this.email,
    required this.name,
    required this.phone,
    required this.bornDate,
    required this.address,

  });

  @override
  List<Object> get props => [email,name,phone,bornDate,address];

  @override
  String toString() => 'SignUpButtonPressed { email: $email, }';
}

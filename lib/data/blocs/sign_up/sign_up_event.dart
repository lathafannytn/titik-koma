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
  final String code;




  const SignUpButtonPressed({
    required this.email,
    required this.name,
    required this.phone,
    required this.bornDate,
    required this.address,
    required this.code,

  });

  @override
  List<Object> get props => [email,name,phone,bornDate,address,code];

  @override
  String toString() => 'SignUpButtonPressed { email: $email, }';
}

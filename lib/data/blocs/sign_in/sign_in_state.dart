part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

// class SignInSuccess extends SignInState {
//   final SignInResponse signInResponse;

//   const SignInSuccess({required this.signInResponse});
//   print(SignInSuccess) {
//     // TODO: implement print
//     throw UnimplementedError();
//   }

//   @override
//   List<Object> get props => [signInResponse];
// }
class  SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

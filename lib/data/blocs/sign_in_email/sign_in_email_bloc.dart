import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tikom/data/repository/auth_repository_email.dart';

part 'sign_in_email_event.dart';
part 'sign_in_email_state.dart';

class SignInEmailBloc extends Bloc<SignInEmailEvent, SignInEmailState> {
  SignInEmailBloc() : super(SignInInitial()) {
    on<SignInEmailEvent>(onSignInEmailEvent);
  }

  final AuthenticationEmailRepository authenticationRepository =
      AuthenticationEmailRepository();

  void onSignInEmailEvent(
      SignInEmailEvent event, Emitter<SignInEmailState> emit) async {
    if (event is SignInButtonPressed) {
      emit(SignInLoading());

      try {
        final signInResponse=  await authenticationRepository.authenticate(
          email: event.email,
        );
           if (signInResponse.status == 'success') {
              emit(SignInSuccess(message: signInResponse.message));
        } else {
              emit(SignInFailure(message: signInResponse.message,error: signInResponse.error ?? 'Unknown error'));
        }
      } catch (error) {
        emit(SignInFailure(message: 'Server Error ',error: error.toString()));
      }
    }
  }
}

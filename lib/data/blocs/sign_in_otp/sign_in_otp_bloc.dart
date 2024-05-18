import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tikom/data/repository/auth_repository_email.dart';
import 'package:tikom/data/repository/auth_repository_otp.dart';

part 'sign_in_otp_event.dart';
part 'sign_in_otp_state.dart';

class SignInEmailOtpBloc extends Bloc<SignInEmailOtpEvent, SignInEmailOtpState> {
  SignInEmailOtpBloc() : super(SignInInitial()) {
    on<SignInEmailOtpEvent>(onSignInEmailOtpEvent);
  }

  final AuthenticationEmailOtpRepository authenticationRepository =
      AuthenticationEmailOtpRepository();

  void onSignInEmailOtpEvent(
      SignInEmailOtpEvent event, Emitter<SignInEmailOtpState> emit) async {
    if (event is SignInButtonPressed) {
      emit(SignInLoading());

      try {
       final signInResponse = await authenticationRepository.authenticate(
          email: event.email,
          otp:event.otp
        );
         if (signInResponse.status == 'success') {
              emit(SignInSuccess());
        } else {
              emit(SignInFailure(error: signInResponse.error ?? 'Unknown error'));
        }
      } catch (error) {
        emit(SignInFailure(error: error.toString()));
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/repository/auth_repository_sign_up.dart';



part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>(onSignUpEvent);
  }

  final AuthenticationSignUpRepository authenticationRepository =
      AuthenticationSignUpRepository();

  void onSignUpEvent(
      SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignUpButtonPressed) {
      emit(SignUpLoading());

      try {
       final signUpResponse = await authenticationRepository.authenticate(
          email: event.email,
          name:event.name,
          phone:event.phone,
          bornDate:event.bornDate,
          address: event.address,
          code: event.code,
        );
         if (signUpResponse.status == 'success') {
              emit(SignUpSuccess());
        } else {
              emit(SignUpFailure(error: signUpResponse.error ?? 'Unknown error'));
        }
      } catch (error) {
        emit(SignUpFailure(error: error.toString()));
      }
    }
  }
}

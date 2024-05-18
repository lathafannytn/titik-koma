import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tikom/data/repository/auth_repository.dart';

part 'sign_in_google_event.dart';
part 'sign_in_google_state.dart';

class SignInGoogleBloc extends Bloc<SignInGoogleEvent, SignInGoogleState> {
  SignInGoogleBloc() : super(SignInInitial()) {
    on<SignInGoogleEvent>(onSignInGoogleEvent);
  }

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  void onSignInGoogleEvent(
      SignInGoogleEvent event, Emitter<SignInGoogleState> emit) async {
    if (event is SignInButtonPressed) {
      emit(SignInLoading());

      try {
        await authenticationRepository.authenticate(
          email: event.email,
          password: event.password,
        );
      } catch (error) {
        emit(SignInFailure(error: error.toString()));
      }
    }
  }
}

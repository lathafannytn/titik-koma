import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tikom/data/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>(onSignInEvent);
  }

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  void onSignInEvent(
      SignInEvent event, Emitter<SignInState> emit) async {
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

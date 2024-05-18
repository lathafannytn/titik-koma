import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>(onSignInEvent);
  }

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  void onSignInEvent(SignInEvent event, Emitter<SignInState> emit) async {
    if (event is SignInButtonPressed) {
      emit(SignInLoading());
      print('masuk');
      try {
      final signInResponse = await authenticationRepository.authenticate(
          email: event.email,
          password: event.password,
        );
      if (signInResponse.status == 'success') {
              emit(SignInSuccess());
        } else {
              emit(SignInFailure(error: signInResponse.error ?? 'Unknown error'));
        }
      } catch (error) {
        print('error');
        print(error);
        emit(SignInFailure(error: 'Disini?$error'));
      }
    }
  }
}

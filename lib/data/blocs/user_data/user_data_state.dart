import 'package:bloc/bloc.dart';
import 'package:tikom/data/models/user.dart';

class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final User user;
  UserDataLoaded(this.user);
}

class UserDataError extends UserDataState {
  final String message;
  UserDataError(this.message);
}
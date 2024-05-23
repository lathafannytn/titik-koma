import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikom/data/blocs/user_data/user_data_state.dart';
import 'package:tikom/data/models/user.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/data/repository/user_repository.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());


  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();

 
  Future<void> loadUserData() async {
    emit(UserDataLoading());
    try {
      final userResponse = await _userRepository.fetchUser();
      if (userResponse != null && userResponse.data != null) {
        emit(UserDataLoaded(userResponse.data!));
      } else {
        emit(UserDataError('User data is null'));
      }
    } catch (error) {
      emit(UserDataError(error.toString()));
    }
  }

  
}

// class UserDataCubit extends Cubit<UserDataState> {
//   UserDataCubit()
//       : super(UserDataState(
//           user: null,
//         ));


//   final AuthenticationRepository authenticationRepository =
//       AuthenticationRepository();
//   final UserRepository _userRepository = UserRepository();



//   void setData({User? user}) {
//     emit(UserDataState(
//       user: user ?? state.user,
//     ));
//   }


//   void logout() async {
//     await authenticationRepository.deleteToken();
//   }



  
// }


// Future<void> loadUser() async {
//     try {
//       final UserResponse userResponse = await _userRepository.fetchUser();
//       print('load User');
//       print(userResponse);
//       setData(
//         user: userResponse.data,
//       );
//     } catch (error) {
//       print("LOAD USER ERROR : ${error.toString()}");
//       emit(UserDataFailure(error.toString()));
//     }
//   }

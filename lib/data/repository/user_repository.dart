import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:tikom/api/api_provider.dart';
import 'package:tikom/data/models/point_history.dart';
import 'package:tikom/data/models/user.dart';
import 'package:tikom/data/repository/auth_repository.dart';

class UserRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  Future<UserResponse> fetchUser() async {
    print("Fetching user... Masuk");
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("my-profil", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    });
    print('repo');
    print('token');
    print(response);
    return UserResponse.fromJson(response);
  }

  Future<PointHistoryResponse> fetchMyPoint() async {
    print("Fetching My Point... Masuk");
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("my-history-point", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    });
    print('repo');
    print('token');
    print(response);
    return PointHistoryResponse.fromJson(response);
  }


}

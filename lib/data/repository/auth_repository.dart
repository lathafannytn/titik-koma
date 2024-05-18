import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class AuthenticationRepository {
  final ApiProvider _provider = ApiProvider();

  /// Fetch sign in response from api
  Future<SignInResponse> authenticate({
    required String email,
    required String password,
  }) async {
    SignInRequest body = SignInRequest(email: email, password: password);
    final response = await _provider
        .post("/auth/login", body: jsonEncode(body.toJson()), headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (json.decode(response.body)['status'] == 'success') {
      String token = json.decode(response.body)['token'];
      await persistToken(token);
    }
    return SignInResponse.fromJson(response);
  }

  /// Delete available token
  Future<void> deleteToken() async {
    StorageService.removeData(tokenKey);
    return;
  }

  /// Write to keystore/keychain
  Future<void> persistToken(String token) async {
    StorageService.saveData(tokenKey, token);
    return;
  }

  /// Read and check if token exists
  Future<bool> hasToken() async {
    return StorageService.getToken(tokenKey) == null ? false : true;
  }

  Future<String> getToken() async {
    return StorageService.getToken(tokenKey);
  }
}

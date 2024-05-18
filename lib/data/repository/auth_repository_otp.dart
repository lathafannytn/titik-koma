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

class AuthenticationEmailOtpRepository {
  final ApiProvider _provider = ApiProvider();

  /// Fetch sign in response from api
  Future<SignInResponse> authenticate({
    required String email,
    required String otp,
  }) async {
    final body = jsonEncode({
      'email': email,
      'otp': otp,
    });

    final response = await _provider.post(
      'auth/login-verif-email-otp',
      body: body,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response['status'] == 'success') {
      String token = response['token'];
      persistToken(token);
    }
    return SignInResponse.fromJson(response);
  }

  /// Delete available token
  Future<void> deleteToken() async {
    StorageService.removeData(tokenKey);
    return;
  }

  /// Write to keystore/keychain
  Future<Future<String>> persistToken(String token) async {
    StorageService.saveData(tokenKey, token);
    return getToken();
  }

  /// Read and check if token exists
  Future<bool> hasToken() async {
    return StorageService.getToken(tokenKey) == null ? false : true;
  }

  Future<String> getToken() async {
    return StorageService.getToken(tokenKey);
  }
}

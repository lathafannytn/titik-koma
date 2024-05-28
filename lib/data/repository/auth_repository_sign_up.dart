import 'dart:convert';
import 'dart:io';

import 'package:tikom/api/api.dart';
import 'package:tikom/data/models/sign_up.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;

const String tokenKey = 'token';

class AuthenticationSignUpRepository {
  final ApiProvider _provider = ApiProvider();

  /// Fetch sign in response from api
  Future<SignUpResponse> authenticate({
    required String email,
    required String name,
    required String phone,
    required String bornDate,
    required String address,
    required String code,
  }) async {
    final body = jsonEncode({
      'email': email,
      'name': name,
      'phone': phone,
      'bornDate': bornDate,
      'address': address,
      'referral_code': code
    });

    final response = await _provider.post(
      'auth/register-new',
      body: body,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return SignUpResponse.fromJson(response);
  }

}

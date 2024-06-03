import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/my_voucher.dart';
import 'package:tikom/data/models/order.dart';
import 'package:tikom/data/models/order_product.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class MyVoucherRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  Future<MyVoucherResponse> fetchVoucher() async {
    print("Fetching voucher... Masuk");
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get("my-voucher", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    });
    print('repo');
    print('token');
    print(response);
    return MyVoucherResponse.fromJson(response);
  }

  Future<MyVoucherResponse> claimVoucher({required String code}) async {
    print("claim voucher... Masuk");
    final body = jsonEncode({
      'code': code,
    });
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.post(
      'voucher/claim',
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('repo');
    print('token');
    print(response);
    return MyVoucherResponse.fromJson(response);
  }
}

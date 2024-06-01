import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/models/transaction.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class TransactionRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  /// Fetch sign in response from api
  Future<TransactionStoreResponse> store({
    required int price,
    required String voucher,
    required String payment_method,
    required String use_point,
  }) async {
    final body = jsonEncode({
      'price': price,
      'voucher': voucher,
      'payment_type': payment_method,
      'use_point': use_point,
    });
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.post(
      'transaction/store',
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('disini store trans');
    print(response);
    return TransactionStoreResponse.fromJson(response);
  }


  Future<TransactionResponse> dataStatus({
    required String filter,
  }) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get(
      'transaction/data-by-status/$filter',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return TransactionResponse.fromJson(response);
  }

   Future<TransactionResponse> data() async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get(
      'transaction/data',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return TransactionResponse.fromJson(response);
  }

  Future<TransactionResponse> dataDetail({
    required String uuid,
  }) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get(
      'transaction/data/$uuid',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return TransactionResponse.fromJson(response);
  }

}

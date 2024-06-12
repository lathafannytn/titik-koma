import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/add_on_catering.dart';
import 'package:tikom/data/models/drinks.dart';

import 'package:tikom/data/models/full_service.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class FullServiceRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  Future<FullServiceResponse> showFullService() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'full-service/service',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return FullServiceResponse.fromJson(response);
  }

  Future<AddOnCateringResponse> showAddOnCatering() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'full-service/add-on-catering',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return AddOnCateringResponse.fromJson(response);
  }

  Future<DrinkResponse> showProductFullService() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'full-service/product',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return DrinkResponse.fromJson(response);
  }

  Future<TransactionFullServiceStoreResponse> store(
      {required int price,
      required String voucher,
      required String custom_cup_name,
      required String custom_cup_note,
      required String products,
          required List<String> add_on,
      required String payment_method,
      required String use_point,
      required dynamic base_delivery,
      required dynamic delivery_address,
      required dynamic delivery_price}) async {
    final body = jsonEncode({
      'price': price,
      'voucher': voucher,
      'payment_type': payment_method,
      'products': products,
      'custom_cup_name': custom_cup_name,
      'custom_cup_note':custom_cup_note,
      'use_point': use_point,
      'base_delivery': base_delivery,
      'delivery_address': delivery_address,
      'delivery_price': delivery_price,
      'add_on': add_on
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
    return TransactionFullServiceStoreResponse.fromJson(response);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/add_on_catering.dart';
import 'package:tikom/data/models/bundle.dart';
import 'package:tikom/data/models/drinks.dart';

import 'package:tikom/data/models/full_service.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/models/transaction_full_service.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class FullServiceCafeRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();


  Future<BundleResponse> showBundle() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'full-service/bundle',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return BundleResponse.fromJson(response);
  }

  Future<BundleResponse> showBundleProduct(dynamic bundle_id) async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'full-service/bundle-product/$bundle_id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return BundleResponse.fromJson(response);
  }

  Future<TransactionFullServiceStoreResponse> store(
      {
        required  List<List<String>> product_list,
        required String package,
        required int price,
      required String voucher,
      required dynamic service,
      required String service_date,
      required String custom_cup_name,
      required String custom_cup_note,
      required Map<String, List<String>> add_on,
      required String payment_method,
      required String use_point,
      required dynamic base_delivery,
      required dynamic delivery_address,
      required dynamic delivery_price}) async {
    final body = jsonEncode({
      'service_date' : service_date,
      'service': service,
      'price': price,
      'voucher': voucher,
      'payment_type': payment_method,
      'custom_cup_name': custom_cup_name,
      'custom_cup_note':custom_cup_note,
      'use_point': use_point,
      'base_delivery': base_delivery,
      'delivery_address': delivery_address,
      'delivery_price': delivery_price,
      'add_on': add_on,
      'products': product_list,
      'package':package
    });
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.post(
      'full-service/store-cafe',
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

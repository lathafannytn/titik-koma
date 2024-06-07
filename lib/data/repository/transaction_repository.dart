import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/models/transaction.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';
import 'package:tikom/utils/constant.dart' as AppConst;

const String tokenKey = 'token';

class TransactionRepository {
  final ApiProvider _provider = ApiProvider();
  final String _baseUrl = AppConst.Constants.baseURL;

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final Dio dio = new Dio();

  /// Fetch sign in response from api
  Future<TransactionStoreResponse> store({
    required int price,
    required String voucher,
    required String payment_method,
    required String use_point,
    required String service_date,
    required dynamic base_delivery,
    required dynamic is_delivery,
    required dynamic delivery_address,
    required dynamic delivery_price
  }) async {
    final body = jsonEncode({
      'price': price,
      'voucher': voucher,
      'payment_type': payment_method,
      'use_point': use_point,
      'service_date':service_date,
      'base_delivery' : base_delivery,
      'is_delivery': is_delivery,
      'delivery_address' : delivery_address,
      'delivery_price' : delivery_price
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

  /// Fetch sign in response from api
  Future<TransactionStoreResponse> payment({
    required String uuidOrder,
    required String imagePayment,
  }) async {
    final _token = await _authenticationRepository.getToken();
    FormData formDataGeneral;
    formDataGeneral = FormData.fromMap({
      "order_uuid": uuidOrder,
      "image_payment":
          await MultipartFile.fromFile(imagePayment, filename: "payment"),
    });

    final response = await dio.post(
      "${_baseUrl}transaction/payment/store",
      data: formDataGeneral,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.contentTypeHeader: 'application/json',
      }, validateStatus: (status) => true),
    );
    print('disini store trans');
    print(response.data);
    return TransactionStoreResponse.fromJson(response.data);
  }

  Future<BaseDeliveryResponse> showDeliveryBase({
    required String type
  }) async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'transaction/get-base-delivery/$type',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return BaseDeliveryResponse.fromJson(response);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/order.dart';
import 'package:tikom/data/models/order_product.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class OrderRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  /// Fetch sign in response from api
  Future<OrderResponse> authenticate({
    required List<String> products,
    required String selected,
    required List<String> add_on,
    required double total,
  }) async {
    final body = jsonEncode({
      'products': products,
      'add_on': add_on,
      'selected': selected,
      'total': total,
    });
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.post(
      'order/store',
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return OrderResponse.fromJson(response);
  }

  Future<OrderDataResponse> showOrder() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'order/data',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return OrderDataResponse.fromJson(response);
  }

  Future<OrderProductResponse> showOrderProduct() async {
    final _token = await _authenticationRepository.getToken();
    print('token');
    print(_token);
    final response = await _provider.get(
      'order/data-product',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return OrderProductResponse.fromJson(response);
  }

  Future<String> plusMinus({
      required String uuid,
      required String action,

    }) async {
      final body = jsonEncode({
        'uuid': uuid,
        'action': uuid,
      });
      final _token = await _authenticationRepository.getToken();

      final response = await _provider.post(
        'order/handle-plus-minus',
        body: body,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      print(response);
      return json.encode(response);
  }


}

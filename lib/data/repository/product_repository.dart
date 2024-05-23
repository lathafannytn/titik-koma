import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/add_on_product.dart';
import 'package:tikom/data/models/product.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

class ProductDetailRepository {
  final ApiProvider _provider = ApiProvider();

  String token = StorageService.getToken('token');

  /// Fetch from api
  Future<ProductDetailResponse> showDetail({
    required String uuid,
  }) async {
    final response = await _provider.get(
      'product/$uuid',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return ProductDetailResponse.fromJson(response);
  }

  Future<AddOnProductResponse>  addOnProductIceLevel() async {
    final response = await _provider.get(
      'add-on-product/ice-level',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return AddOnProductResponse.fromJson(response);
  }

  Future<AddOnProductResponse>  addOnProductCupSize() async {
    final response = await _provider.get(
      'add-on-product/cup-size',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor Cup Size');
    print(response);

    return AddOnProductResponse.fromJson(response);
  }

  Future<AddOnProductResponse>  addOnProductSugar() async {
    final response = await _provider.get(
      'add-on-product/sugar',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return AddOnProductResponse.fromJson(response);
  }


}

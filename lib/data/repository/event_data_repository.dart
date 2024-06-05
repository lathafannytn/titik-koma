import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tikom/api/api.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikom/data/models/event_data.dart';
import 'package:tikom/data/models/order.dart';
import 'package:tikom/data/models/order_product.dart';
import 'package:tikom/data/models/sign_in.dart';
import 'package:tikom/data/repository/auth_repository.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;
import 'package:tikom/utils/storage_service.dart';

const String tokenKey = 'token';

class EventDataRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  /// Fetch sign in response from api

  Future<EventDataResponse> data() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'event/data',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return EventDataResponse.fromJson(response);
  }

  Future<EventDataResponse> dataLimit() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'event/data-limit',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return EventDataResponse.fromJson(response);
  }

  Future<EventDataResponse> myEvent() async {
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.get(
      'event/my-event',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return EventDataResponse.fromJson(response);
  }

  Future<EventDetailDataResponse> showDetail({
    required String uuid,
  }) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get(
      'event/detail/$uuid',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return EventDetailDataResponse.fromJson(response);
  }
   Future<EventDetailDataResponse> showMyEventDetail({
    required String uuid,
  }) async {
    final _token = await _authenticationRepository.getToken();
    final response = await _provider.get(
      'event/my-event-detail/$uuid',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print('Form Repositor');
    print(response);

    return EventDetailDataResponse.fromJson(response);
  }

  Future<EventStoreResponse> store({
    required String event,
  }) async {
    final body = jsonEncode({
      'event': event,
    });
    final _token = await _authenticationRepository.getToken();

    final response = await _provider.post(
      'event/store',
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response);
    return EventStoreResponse.fromJson(response);
  }
}

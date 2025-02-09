// Source:
// https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tikom/api/api_exceptions.dart';
// import 'package:startercode_project/api/api.dart';
import 'package:tikom/utils/constant.dart' as AppConst;

class ApiProvider {
  final String _baseUrl = AppConst.Constants.baseURL;
  // Map<String, String> headers = {"Content-type": "application/json"};

  Future<dynamic> get(dynamic url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url) , headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> getWithoutBaseurl(dynamic url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.get(url, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {dynamic body, Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + url), body: body, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {dynamic body, Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response =
          await http.put(Uri.parse(_baseUrl + url) , body: body, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }


  dynamic _returnResponse(http.Response response) {
    var responseJson = json.decode(response.body);
    // final error = responseJson['message'] ?? 'Terjadi kesalahan';
    final error = 'Maaf,Terjadi kesalahan'; //Menyesuaikan response backend

    if (kDebugMode) {
      String responseJsonStr = response.body;
      String endpointPath = response.request!.url.path;
      String endpointStr = response.request!.url.toString();
      String endpointMethod = response.request!.method;

      debugPrint('\x1B[31m\n->\x1B[0m');
      debugPrint('\x1B[37m[$endpointMethod] $endpointStr\x1B[0m');
      debugPrint('\x1B[33m$responseJsonStr\x1B[0m');
    }

    // return responseJson;

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        // final statusCode = responseJson['status'] ?? null;
        // final message = responseJson['message'] ?? 'Terjadi kesalahan';
        // final String firstCode = statusCode != null ? statusCode[0] : null;

        // if (statusCode != null && firstCode != "2") {
        //   switch (firstCode) {
        //     case "4":
        //       throw ClientException(message);
        //     case "5":
        //       throw ServerException(message);
        //     default:
        //       throw GeneralException(message);
        //   }
        // }

        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw error;
      case 403:
        throw UnauthorisedException(jsonDecode(response.body.toString()));
      case 500:
        throw ServerException(error);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

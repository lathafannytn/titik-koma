import 'dart:convert';

import 'package:meta/meta.dart';


class UserResponse {
  UserResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  User? data;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        message: json["msg"],
        data: json["data"] != null ? User.fromJson(json["data"]) : null,
      );
}

class User {
  User(
      {
      required this.id,
      required this.name,
      required this.email,
      required this.phonenumber,
      required this.address,
      required this.born,
      required this.referallCode,
      required this.point,
      required this.countVoucher
      });

  int id;
  String name;
  String email;
  String phonenumber;
  dynamic address;
  dynamic born;
  dynamic referallCode;
  dynamic point;
  dynamic countVoucher;


   factory User.fromJson(Map<String, dynamic> json) {
    var profil = json['profil'];
    var voucher = json['voucher'];
    
    return User(
      id: json["id"] ?? 0,
      name: json["name"],
      email: json["email"],
      phonenumber: profil != null ? profil['phone_number'] : null,
      born: profil != null ? profil['born'] : null,
      point: profil != null ? profil['point'] : null,
      referallCode: profil != null ? profil['referral_code'] : null,
      address: profil != null ? profil['address'] : null,
      countVoucher: voucher != null && voucher is List ? voucher.length : 0,
    );
  }

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "email": email,
      "phonenumber": phonenumber,
      "address": address,
      "born":born,
      "referallCode": referallCode,
      "point": point,
      "countVoucher": countVoucher,
  };
}


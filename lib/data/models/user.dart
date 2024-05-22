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
      required this.point
      });

  int id;
  String name;
  String email;
  String phonenumber;
  dynamic address;
  dynamic born;
  dynamic referallCode;
  dynamic point;


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    name: json["name"],
    email: json["email"],
    phonenumber: json['profil']['phone_number'],
    born: json['profil']['born'],
    point: json['profil']['point'],
    referallCode: json['profil']['refferal_code'],
    address: json['profil']['address'],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "email": email,
      "phonenumber": phonenumber,
      "address": address,
      "born":born,
      "referallCode": referallCode,
      "point": point,
  };
}


class SignUpRequest {
  SignUpRequest({
    required this.email,
    required this.name,
    required this.phone,
    required this.bornDate,
    required this.address,


  });

  String email;
  String name;
  String phone;
  String bornDate;
  String address;


  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "phone": phone,
    "bornDate": bornDate,
    "address": address,

  };
}

class SignUpResponse {
  final String status;
  dynamic token;
  String message;
  final String? error;

  SignUpResponse(
      {required this.status, this.token, required this.message, this.error});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json['status'],
        token: json["token"],
        message: json["msg"],
        error: json['error'],
      );
}

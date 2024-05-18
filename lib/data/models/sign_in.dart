class SignInRequest {
  SignInRequest({
    required this.email,
    required this.password,

  });

  String email;
  String password;


  Map<String, dynamic> toJson() => {
      "email": email,
      "password": password,
  };
}

class SignInResponse {
  final String status;
  dynamic token;
  String message;
  final String? error;

  SignInResponse({
    required this.status,
    this.token,
    required this.message,
    this.error
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        status: json['status'],
        token: json["token"],
        message: json["msg"],
        error: json['error'],
  );
}

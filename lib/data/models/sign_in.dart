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
  dynamic token;
  String message;

  SignInResponse({
    this.token,
    required this.message,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        token: json["token"],
        message: json["msg"],
  );
}

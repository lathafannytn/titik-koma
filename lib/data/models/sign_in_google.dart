class SignInGoogleRequest {
  SignInGoogleRequest({
    required this.email,
    required this.id,
    required this.displayName,

  });

  String email;
  int id;
  String displayName;


  Map<String, dynamic> toJson() => {
      "email": email,
      "id": id,
      "displayName": id,
  };
}

class SignInGoogleResponse {
  dynamic token;
  String message;

  SignInGoogleResponse({
    this.token,
    required this.message,
  });

  factory SignInGoogleResponse.fromJson(Map<String, dynamic> json) => SignInGoogleResponse(
        token: json["token"],
        message: json["msg"],
  );
}

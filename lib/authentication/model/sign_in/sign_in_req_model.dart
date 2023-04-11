class SignInReqModel {
  SignInReqModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory SignInReqModel.fromJson(Map<String, dynamic> json) => SignInReqModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

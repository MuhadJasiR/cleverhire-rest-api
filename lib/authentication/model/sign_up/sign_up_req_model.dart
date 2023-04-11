class SignUpReqModel {
  SignUpReqModel({
    required this.email,
    required this.password,
    required this.username,
  });

  String email;
  String password;
  String username;

  factory SignUpReqModel.fromJson(Map<String, dynamic> json) => SignUpReqModel(
        email: json["email"],
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
      };
}

class SignUpResModel {
  SignUpResModel({
    required this.message,
    required this.accessToken,
  });

  String message;
  String accessToken;

  factory SignUpResModel.fromJson(Map<String, dynamic> json) => SignUpResModel(
        message: json["message"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "access_token": accessToken,
      };
}

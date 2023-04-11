class SignUpOtpModel {
  SignUpOtpModel({
    required this.email,
    required this.otp,
  });

  String email;
  int otp;

  factory SignUpOtpModel.fromJson(Map<String, dynamic> json) => SignUpOtpModel(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}

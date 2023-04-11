import 'dart:convert';

SignInRes signInResFromJson(String str) => SignInRes.fromJson(json.decode(str));

String signInResToJson(SignInRes data) => json.encode(data.toJson());

class SignInRes {
  SignInRes({
    required this.user,
    required this.accessToken,
  });

  User user;
  String accessToken;

  factory SignInRes.fromJson(Map<String, dynamic> json) => SignInRes(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.verified,
    required this.role,
    required this.v,
  });

  String id;
  String username;
  String email;
  bool verified;
  String role;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        verified: json["verified"],
        role: json["role"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "verified": verified,
        "role": role,
        "__v": v,
      };
}





// class SignInResModel {
//   SignInResModel({required this.accessToken, required this.user});

//   String accessToken;
//   User user;

//   factory SignInResModel.fromJson(Map<String, dynamic> json) =>
//       SignInResModel(accessToken: json["access_token"], user: json["user"]);

//   Map<String, dynamic> toJson() => {
//         "access_token": accessToken,
//       };
// }

// class User {
//   User({required this.role});
//   String role;
//   factory User.fromJson(Map<String, dynamic> json) => User(role: json["role"]);
//   Map<String, dynamic> toJson() => {"role": role};
// }

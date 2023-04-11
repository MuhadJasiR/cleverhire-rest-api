class GetUploadImageModel {
  GetUploadImageModel({
    required this.id,
    required this.description,
    required this.user,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String description;
  User user;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory GetUploadImageModel.fromJson(Map<String, dynamic> json) =>
      GetUploadImageModel(
        id: json["_id"],
        description: json["description"],
        user: User.fromJson(json["user"]),
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "user": user.toJson(),
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.otp,
    required this.verified,
    required this.role,
    required this.v,
  });

  String id;
  String username;
  String email;
  String password;
  int otp;
  bool verified;
  String role;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        otp: json["otp"],
        verified: json["verified"],
        role: json["role"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "otp": otp,
        "verified": verified,
        "role": role,
        "__v": v,
      };
}

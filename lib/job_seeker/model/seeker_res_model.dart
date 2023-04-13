class SeekerDetailsResModel {
  SeekerDetailsResModel({
    required this.id,
    required this.username,
    required this.email,
    required this.otp,
    required this.verified,
    required this.role,
    required this.v,
    required this.profile,
  });

  String id;
  String username;
  String email;
  int otp;
  bool verified;
  String role;
  int v;
  Profile profile;

  factory SeekerDetailsResModel.fromJson(Map<String, dynamic> json) =>
      SeekerDetailsResModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        otp: json["otp"],
        verified: json["verified"],
        role: json["role"],
        v: json["__v"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "otp": otp,
        "verified": verified,
        "role": role,
        "__v": v,
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.dateOfBirth,
    required this.address,
    required this.profileImage,
  });

  DateTime dateOfBirth;
  String address;
  String profileImage;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        address: json["address"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "date_of_birth": dateOfBirth.toIso8601String(),
        "address": address,
        "profile_image": profileImage,
      };
}

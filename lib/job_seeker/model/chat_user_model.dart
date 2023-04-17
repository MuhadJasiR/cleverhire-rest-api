class GetAllChatModel {
  GetAllChatModel({
    required this.id,
    required this.members,
    required this.v,
  });

  String id;
  List<Member> members;
  int v;

  factory GetAllChatModel.fromJson(Map<String, dynamic> json) =>
      GetAllChatModel(
        id: json["_id"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "__v": v,
      };
}

class Member {
  Member({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.otp,
    required this.verified,
    required this.role,
    required this.v,
    this.profile,
  });

  String id;
  String username;
  String email;
  String password;
  int otp;
  bool verified;
  String role;
  int v;
  Profile? profile;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        otp: json["otp"],
        verified: json["verified"],
        role: json["role"],
        v: json["__v"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
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
        "profile": profile?.toJson(),
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

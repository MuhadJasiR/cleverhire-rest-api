class GetAppliedPeopleModel {
  GetAppliedPeopleModel({
    required this.id,
    required this.appliedBy,
    required this.jobId,
    required this.resume,
    required this.status,
    required this.v,
    required this.profile,
  });

  String id;
  AppliedBy appliedBy;
  String jobId;
  String resume;
  String status;
  int v;
  List<Profile> profile;

  factory GetAppliedPeopleModel.fromJson(Map<String, dynamic> json) =>
      GetAppliedPeopleModel(
        id: json["_id"],
        appliedBy: AppliedBy.fromJson(json["applied_by"]),
        jobId: json["job_id"],
        resume: json["resume"],
        status: json["status"],
        v: json["__v"],
        profile:
            List<Profile>.from(json["profile"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "applied_by": appliedBy.toJson(),
        "job_id": jobId,
        "resume": resume,
        "status": status,
        "__v": v,
        "profile": List<dynamic>.from(profile.map((x) => x.toJson())),
      };
}

class AppliedBy {
  AppliedBy({
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

  factory AppliedBy.fromJson(Map<String, dynamic> json) => AppliedBy(
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

class Profile {
  Profile({
    required this.id,
    required this.dateOfBirth,
    required this.user,
    required this.address,
    required this.profileImage,
    required this.v,
  });

  String id;
  DateTime dateOfBirth;
  String user;
  String address;
  String profileImage;
  int v;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        user: json["user"],
        address: json["address"],
        profileImage: json["profile_image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "user": user,
        "address": address,
        "profile_image": profileImage,
        "__v": v,
      };
}

class SeekerReqModel {
  SeekerReqModel({
    required this.dateOfBirth,
    required this.address,
    required this.occupation,
    required this.profileImage,
  });

  String dateOfBirth;
  String address;
  String occupation;
  String profileImage;

  factory SeekerReqModel.fromJson(Map<String, dynamic> json) => SeekerReqModel(
        dateOfBirth: json["date_of_birth"],
        address: json["address"],
        occupation: json["occupation"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "date_of_birth": dateOfBirth,
        "address": address,
        "occupation": occupation,
        "profile_image": profileImage,
      };
}

class DateOfBirth {
  DateOfBirth();

  factory DateOfBirth.fromJson(Map<String, dynamic> json) => DateOfBirth();

  Map<String, dynamic> toJson() => {};
}

class CreateVacancyResModel {
  CreateVacancyResModel({
    required this.id,
    required this.position,
    this.companyId,
    required this.locationType,
    required this.salary,
    required this.type,
    required this.description,
    required this.v,
    this.company,
  });

  String id;
  String position;
  String? companyId;
  String locationType;
  int salary;
  String type;
  String description;
  int v;
  Company? company;

  factory CreateVacancyResModel.fromJson(Map<String, dynamic> json) =>
      CreateVacancyResModel(
        id: json["_id"],
        position: json["position"],
        companyId: json["company_id"],
        locationType: json["location_type"],
        salary: json["salary"],
        type: json["type"],
        description: json["description"],
        v: json["__v"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "position": position,
        "company_id": companyId,
        "location_type": locationType,
        "salary": salary,
        "type": type,
        "description": description,
        "__v": v,
        "company": company?.toJson(),
      };
}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.user,
    required this.companyEmail,
    required this.establishedDate,
    required this.country,
    required this.address,
    required this.v,
  });

  String id;
  String companyName;
  String user;
  String companyEmail;
  DateTime establishedDate;
  String country;
  String address;
  int v;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["_id"],
        companyName: json["company_name"],
        user: json["user"],
        companyEmail: json["company_email"],
        establishedDate: DateTime.parse(json["established_date"]),
        country: json["country"],
        address: json["address"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "company_name": companyName,
        "user": user,
        "company_email": companyEmail,
        "established_date": establishedDate.toIso8601String(),
        "country": country,
        "address": address,
        "__v": v,
      };
}

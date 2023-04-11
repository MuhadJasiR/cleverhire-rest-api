class CompanyReqModel {
  CompanyReqModel({
    required this.companyName,
    required this.establishedDate,
    required this.companyEmail,
    required this.country,
    required this.address,
  });

  String companyName;
  String establishedDate;
  String companyEmail;
  String country;
  String address;

  factory CompanyReqModel.fromJson(Map<String, dynamic> json) =>
      CompanyReqModel(
        companyName: json["company_name"],
        establishedDate: json["established_date"],
        companyEmail: json["company_email"],
        country: json["country"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "established_date": establishedDate,
        "company_email": companyEmail,
        "country": country,
        "address": address,
      };
}

class CreateVacancyModel {
  CreateVacancyModel({
    required this.position,
    required this.salary,
    required this.locationType,
    required this.type,
    required this.description,
  });

  String position;
  int salary;
  String locationType;
  String type;
  String description;

  factory CreateVacancyModel.fromJson(Map<String, dynamic> json) =>
      CreateVacancyModel(
        position: json["position"],
        salary: json["salary"],
        locationType: json["location_type"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "salary": salary,
        "location_type": locationType,
        "type": type,
        "description": description,
      };
}

class ApplyingForVacancyModel {
  ApplyingForVacancyModel({
    required this.resume,
  });

  String resume;

  factory ApplyingForVacancyModel.fromJson(Map<String, dynamic> json) =>
      ApplyingForVacancyModel(
        resume: json["resume"],
      );

  Map<String, dynamic> toJson() => {
        "resume": resume,
      };
}

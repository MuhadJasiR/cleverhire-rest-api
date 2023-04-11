class UploadImageModel {
  UploadImageModel({
    required this.description,
    required this.image,
  });

  String description;
  String image;

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "image": image,
      };
}

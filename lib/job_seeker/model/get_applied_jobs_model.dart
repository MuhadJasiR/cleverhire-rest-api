class GetAppliedJobsModel {
  GetAppliedJobsModel({
    required this.id,
    this.jobId,
    required this.resume,
    required this.status,
    required this.v,
  });

  String id;
  JobId? jobId;
  String resume;
  String status;
  int v;

  factory GetAppliedJobsModel.fromJson(Map<String, dynamic> json) =>
      GetAppliedJobsModel(
        id: json["_id"],
        jobId: json["job_id"] == null ? null : JobId.fromJson(json["job_id"]),
        resume: json["resume"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "job_id": jobId?.toJson(),
        "resume": resume,
        "status": status,
        "__v": v,
      };
}

class JobId {
  JobId({
    required this.id,
    required this.position,
    required this.company,
    required this.locationType,
    required this.salary,
    required this.type,
    required this.description,
    required this.v,
  });

  String id;
  String position;
  String company;
  String locationType;
  int salary;
  String type;
  String description;
  int v;

  factory JobId.fromJson(Map<String, dynamic> json) => JobId(
        id: json["_id"],
        position: json["position"],
        company: json["company"],
        locationType: json["location_type"],
        salary: json["salary"],
        type: json["type"],
        description: json["description"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "position": position,
        "company": company,
        "location_type": locationType,
        "salary": salary,
        "type": type,
        "description": description,
        "__v": v,
      };
}

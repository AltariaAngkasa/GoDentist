class DetectionTeethResponse {
  bool? status;
  String? message;
  Data? data;

  DetectionTeethResponse({
    this.status,
    this.message,
    this.data,
  });

  factory DetectionTeethResponse.fromJson(Map<String, dynamic> json) =>
      DetectionTeethResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? diseaseStatus;
  Teeth? frontTeeth;
  Teeth? upperTeeth;
  Teeth? lowerTeeth;

  Data({
    this.diseaseStatus,
    this.frontTeeth,
    this.upperTeeth,
    this.lowerTeeth,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        diseaseStatus: json["diseaseStatus"],
        frontTeeth: json["frontTeeth"] == null ? null : Teeth.fromJson(json["frontTeeth"]),
        upperTeeth: json["upperTeeth"] == null ? null : Teeth.fromJson(json["upperTeeth"]),
        lowerTeeth: json["lowerTeeth"] == null ? null : Teeth.fromJson(json["lowerTeeth"]),
      );

  Map<String, dynamic> toJson() => {
        "diseaseStatus": diseaseStatus,
        "frontTeeth": frontTeeth?.toJson(),
        "upperTeeth": upperTeeth?.toJson(),
        "lowerTeeth": lowerTeeth?.toJson(),
      };
}

class Teeth {
  String? name;
  String? imageUrl;
  String? diseaseName;
  String? cause;
  String? treatment;

  Teeth({
    this.name,
    this.imageUrl,
    this.diseaseName,
    this.cause,
    this.treatment,
  });

  factory Teeth.fromJson(Map<String, dynamic> json) => Teeth(
        name: json["name"],
        imageUrl: json["imageUrl"],
        diseaseName: json["diseaseName"],
        cause: json["cause"],
        treatment: json["treatment"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "diseaseName": diseaseName,
        "cause": cause,
        "treatment": treatment,
      };
}

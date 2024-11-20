class PromoResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  PromoResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PromoResponse.fromJson(Map<String, dynamic> json) => PromoResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? idClinic;
  String? name;
  String? description;
  String? photo;
  String? clinicName;

  Datum({
    this.id,
    this.idClinic,
    this.name,
    this.description,
    this.photo,
    this.clinicName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idClinic: json["idClinic"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        clinicName: json["clinicName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idClinic": idClinic,
        "name": name,
        "description": description,
        "photo": photo,
        "clinicName": clinicName,
      };
}

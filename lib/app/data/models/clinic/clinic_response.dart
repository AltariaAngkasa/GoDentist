class ClinicResponse {
  bool? status;
  String? message;
  List<ClinicData>? data;

  ClinicResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ClinicResponse.fromJson(Map<String, dynamic> json) => ClinicResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ClinicData>.from(json["data"]!.map((x) => ClinicData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClinicData {
  int? id;
  String? name;
  String? photoUrl;
  dynamic status;
  String? open;
  String? closed;
  String? address;
  String? subDistrict;
  String? city;
  String? province;
  String? postalCode;

  ClinicData({
    this.id,
    this.name,
    this.photoUrl,
    this.status,
    this.open,
    this.closed,
    this.address,
    this.subDistrict,
    this.city,
    this.province,
    this.postalCode,
  });

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoURL"],
        status: json["status"],
        open: json["open"],
        closed: json["closed"],
        address: json["address"],
        subDistrict: json["subDistrict"],
        city: json["city"],
        province: json["province"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoURL": photoUrl,
        "status": status,
        "open": open,
        "closed": closed,
        "address": address,
        "subDistrict": subDistrict,
        "city": city,
        "province": province,
        "postalCode": postalCode,
      };
}

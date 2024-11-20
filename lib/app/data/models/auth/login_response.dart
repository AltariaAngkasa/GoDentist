class LoginResponse {
  bool? status;
  String? message;
  Data? data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
  int? id;
  String? name;
  String? photo;
  String? gender;
  String? phoneNumber;
  String? email;
  String? token;
  DateTime? expiredIn;

  Data({
    this.id,
    this.name,
    this.photo,
    this.gender,
    this.phoneNumber,
    this.email,
    this.token,
    this.expiredIn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        token: json["token"],
        expiredIn: json["expiredIn"] == null
            ? null
            : DateTime.parse(json["expiredIn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "email": email,
        "token": token,
        "expiredIn": expiredIn?.toIso8601String(),
      };
}

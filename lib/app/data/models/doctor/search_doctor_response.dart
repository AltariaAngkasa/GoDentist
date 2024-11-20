import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';

class SearchDoctorResponse {
  bool? status;
  String? message;
  List<DataSearchDoctor>? data;

  SearchDoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SearchDoctorResponse.fromJson(Map<String, dynamic> json) =>
      SearchDoctorResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataSearchDoctor>.from(
                json["data"]!.map((x) => DataSearchDoctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataSearchDoctor {
  int? id;
  dynamic idClinic;
  String? name;
  String? gender;
  String? address;
  String? email;
  String? photo;
  String? specialization;
  String? workPlace;
  String? consultationPrice;
  List<DoctorExperience>? doctorExperience;
  List<DoctorWorkSchedule>? doctorWorkSchedule;

  DataSearchDoctor({
    this.id,
    this.idClinic,
    this.name,
    this.gender,
    this.address,
    this.email,
    this.photo,
    this.specialization,
    this.workPlace,
    this.consultationPrice,
    this.doctorExperience,
    this.doctorWorkSchedule,
  });

  factory DataSearchDoctor.fromJson(Map<String, dynamic> json) =>
      DataSearchDoctor(
        id: json["id"],
        idClinic: json["idClinic"],
        name: json["name"],
        gender: json["gender"],
        address: json["address"],
        email: json["email"],
        photo: json["photo"],
        specialization: json["specialization"],
        workPlace: json["workPlace"],
        consultationPrice: json["consultationPrice"],
        doctorExperience: json["DoctorExperience"] == null
            ? []
            : List<DoctorExperience>.from(json["DoctorExperience"]!
                .map((x) => DoctorExperience.fromJson(x))),
        doctorWorkSchedule: json["DoctorWorkSchedule"] == null
            ? []
            : List<DoctorWorkSchedule>.from(json["DoctorWorkSchedule"]!
                .map((x) => DoctorWorkSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idClinic": idClinic,
        "name": name,
        "gender": gender,
        "address": address,
        "email": email,
        "photo": photo,
        "specialization": specialization,
        "workPlace": workPlace,
        "consultationPrice": consultationPrice,
        "DoctorExperience": doctorExperience == null
            ? []
            : List<dynamic>.from(doctorExperience!.map((x) => x.toJson())),
        "DoctorWorkSchedule": doctorWorkSchedule == null
            ? []
            : List<dynamic>.from(doctorWorkSchedule!.map((x) => x.toJson())),
      };
}

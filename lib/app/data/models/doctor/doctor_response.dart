import 'package:GoDentist/app/data/models/doctor/search_doctor_response.dart';

class DoctorResponse {
  bool? status;
  String? message;
  List<DoctorResponseData>? data;

  DoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => DoctorResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DoctorResponseData>.from(json["data"]!.map((x) => DoctorResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DoctorResponseData {
  int? id;
  String? name;
  String? photo;
  String? specialization;
  String? workPlace;
  String? consultationPrice;
  List<DoctorWorkSchedule>? doctorWorkSchedule;
  List<DoctorExperience>? doctorExperience;

  DoctorResponseData({
    this.id,
    this.name,
    this.photo,
    this.specialization,
    this.workPlace,
    this.consultationPrice,
    this.doctorWorkSchedule,
    this.doctorExperience,
  });

  factory DoctorResponseData.fromJson(Map<String, dynamic> json) => DoctorResponseData(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        specialization: json["specialization"],
        workPlace: json["workPlace"],
        consultationPrice: json["consultationPrice"],
        doctorWorkSchedule: json["DoctorWorkSchedule"] == null
            ? []
            : List<DoctorWorkSchedule>.from(json["DoctorWorkSchedule"]!
                .map((x) => DoctorWorkSchedule.fromJson(x))),
        doctorExperience: json["DoctorExperience"] == null
            ? []
            : List<DoctorExperience>.from(json["DoctorExperience"]!
                .map((x) => DoctorExperience.fromJson(x))),
      );

  factory DoctorResponseData.fromSearch(DataSearchDoctor data) => DoctorResponseData(
    id: data.id,
    name: data.name,
    photo: data.photo,
    specialization: data.specialization,
    workPlace: data.workPlace,
    consultationPrice: data.consultationPrice,
    doctorWorkSchedule: data.doctorWorkSchedule,
    doctorExperience: data.doctorExperience
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "specialization": specialization,
        "workPlace": workPlace,
        "consultationPrice": consultationPrice,
        "DoctorWorkSchedule": doctorWorkSchedule == null
            ? []
            : List<dynamic>.from(doctorWorkSchedule!.map((x) => x.toJson())),
        "DoctorExperience": doctorExperience == null
            ? []
            : List<dynamic>.from(doctorExperience!.map((x) => x.toJson())),
      };

}

class DoctorExperience {
  int? id;
  dynamic fromYear;
  String? description;

  DoctorExperience({
    this.id,
    this.fromYear,
    this.description,
  });

  factory DoctorExperience.fromJson(Map<String, dynamic> json) =>
      DoctorExperience(
        id: json["id"],
        fromYear: json["fromYear"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromYear": fromYear?.toIso8601String(),
        "description": description,
      };
}

class DoctorWorkSchedule {
  int? id;
  String? fromHour;
  String? untilHour;
  String? fromDay;
  dynamic untilDay;
  Description? description;
  Status? status;

  DoctorWorkSchedule({
    this.id,
    this.fromHour,
    this.untilHour,
    this.fromDay,
    this.untilDay,
    this.description,
    this.status,
  });

  factory DoctorWorkSchedule.fromJson(Map<String, dynamic> json) =>
      DoctorWorkSchedule(
        id: json["id"],
        fromHour: json["fromHour"],
        untilHour: json["untilHour"],
        fromDay: json["fromDay"],
        untilDay: json["untilDay"],
        description: descriptionValues.map[json["description"]],
        status: statusValues.map[json["status"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromHour": fromHour,
        "untilHour": untilHour,
        "fromDay": fromDay,
        "untilDay": untilDay,
        // "description": descriptionValues.reverse[description],
        "status": statusValues.reverse[status],
      };
}

enum Description { KONSULTASI_ONLINE, RUMAH_SAKIT }

final descriptionValues = EnumValues({
  "Konsultasi Online": Description.KONSULTASI_ONLINE,
  "Rumah Sakit": Description.RUMAH_SAKIT
});

// enum FromHour { THE_0800 }

// final fromHourValues = EnumValues({"08:00": FromHour.THE_0800});

enum Status { OFFLINE, ONLINE }

final statusValues =
    EnumValues({"Offline": Status.OFFLINE, "Online": Status.ONLINE});

// enum UntilHour { THE_1100 }

// final untilHourValues = EnumValues({"11:00": UntilHour.THE_1100});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

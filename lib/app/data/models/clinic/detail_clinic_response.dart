class DetailClinicResponse {
  bool? status;
  String? message;
  Data? data;

  DetailClinicResponse({
    this.status,
    this.message,
    this.data,
  });

  factory DetailClinicResponse.fromJson(Map<String, dynamic> json) =>
      DetailClinicResponse(
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
  Clinic? clinic;
  List<Doctor>? doctor;
  List<ClinicService>? clinicService;

  Data({
    this.clinic,
    this.doctor,
    this.clinicService,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clinic: json["clinic"] == null ? null : Clinic.fromJson(json["clinic"]),
        doctor: json["doctor"] == null
            ? []
            : List<Doctor>.from(json["doctor"]!.map((x) => Doctor.fromJson(x))),
        clinicService: json["clinicService"] == null
            ? []
            : List<ClinicService>.from(
                json["clinicService"]!.map((x) => ClinicService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clinic": clinic?.toJson(),
        "doctor": doctor == null
            ? []
            : List<dynamic>.from(doctor!.map((x) => x.toJson())),
        "clinicService": clinicService == null
            ? []
            : List<dynamic>.from(clinicService!.map((x) => x.toJson())),
      };
}

class Clinic {
  String? name;
  String? address;
  dynamic status;
  String? subDistrict;
  String? city;
  String? province;
  String? open;
  String? closed;
  String? postalCode;
  String? latitude;
  String? longitude;
  String? phoneNumber;
  String? photoUrl;
  int? queueQuota;
  String? websiteUrl;

  Clinic({
    this.name,
    this.address,
    this.status,
    this.subDistrict,
    this.city,
    this.province,
    this.open,
    this.closed,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.phoneNumber,
    this.photoUrl,
    this.queueQuota,
    this.websiteUrl,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        name: json["name"],
        address: json["address"],
        status: json["status"],
        subDistrict: json["subDistrict"],
        city: json["city"],
        province: json["province"],
        open: json["open"],
        closed: json["closed"],
        postalCode: json["postalCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoURL"],
        queueQuota: json["queueQuota"],
        websiteUrl: json["websiteURL"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "status": status,
        "subDistrict": subDistrict,
        "city": city,
        "province": province,
        "open": open,
        "closed": closed,
        "postalCode": postalCode,
        "latitude": latitude,
        "longitude": longitude,
        "phoneNumber": phoneNumber,
        "photoURL": photoUrl,
        "queueQuota": queueQuota,
        "websiteURL": websiteUrl,
      };
}

class ClinicService {
  int? id;
  String? serviceName;
  String? price;

  ClinicService({
    this.id,
    this.serviceName,
    this.price,
  });

  factory ClinicService.fromJson(Map<String, dynamic> json) => ClinicService(
        id: json["id"],
        serviceName: json["serviceName"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceName": serviceName,
        "price": price,
      };
}

class Doctor {
  int? id;
  String? name;
  String? specialization;
  String? workPlace;
  String? photo;
  List<DoctorWorkSchedule>? doctorWorkSchedule;

  Doctor({
    this.id,
    this.name,
    this.specialization,
    this.workPlace,
    this.photo,
    this.doctorWorkSchedule,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        specialization: json["specialization"],
        workPlace: json["workPlace"],
        photo: json["photo"],
        doctorWorkSchedule: json["DoctorWorkSchedule"] == null
            ? []
            : List<DoctorWorkSchedule>.from(json["DoctorWorkSchedule"]!
                .map((x) => DoctorWorkSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specialization": specialization,
        "workPlace": workPlace,
        "photo": photo,
        "DoctorWorkSchedule": doctorWorkSchedule == null
            ? []
            : List<dynamic>.from(doctorWorkSchedule!.map((x) => x.toJson())),
      };
}

class DoctorWorkSchedule {
  int? id;
  String? fromHour;
  String? untilHour;
  String? fromDay;
  String? untilDay;
  String? description;
  String? status;

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
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromHour": fromHour,
        "untilHour": untilHour,
        "fromDay": fromDay,
        "untilDay": untilDay,
        "description": description,
        "status": status,
      };
}

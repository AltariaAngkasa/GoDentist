class CheckPaymentBookingDoctorResponse {
  bool? status;
  String? message;
  Data? data;

  CheckPaymentBookingDoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CheckPaymentBookingDoctorResponse.fromJson(
          Map<String, dynamic> json) =>
      CheckPaymentBookingDoctorResponse(
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
  int? idClinic;
  String? patientName;
  String? clinicName;
  String? clinicPhoto;
  String? clinicAddress;
  int? idDoctor;
  String? doctorName;
  String? doctorSpecialization;
  String? doctorPhoto;
  String? date;
  String? startTime;
  String? endTime;
  List<int>? idServices;
  List<String>? servicesName;
  List<ServicePrice>? servicePrice;
  dynamic result;
  String? statusService;
  String? statusBooking;
  int? yourQueue;
  int? queueNow;
  int? queueQuota;
  int? totalBooking;
  MidtransResponse? midtransResponse;

  Data({
    this.id,
    this.idClinic,
    this.patientName,
    this.clinicName,
    this.clinicPhoto,
    this.clinicAddress,
    this.idDoctor,
    this.doctorName,
    this.doctorSpecialization,
    this.doctorPhoto,
    this.date,
    this.startTime,
    this.endTime,
    this.idServices,
    this.servicesName,
    this.servicePrice,
    this.result,
    this.statusService,
    this.statusBooking,
    this.yourQueue,
    this.queueNow,
    this.queueQuota,
    this.totalBooking,
    this.midtransResponse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idClinic: json["idClinic"],
        patientName: json["patientName"],
        clinicName: json["clinicName"],
        clinicPhoto: json["clinicPhoto"],
        clinicAddress: json["clinicAddress"],
        idDoctor: json["idDoctor"],
        doctorName: json["doctorName"],
        doctorSpecialization: json["doctorSpecialization"],
        doctorPhoto: json["doctorPhoto"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        idServices: json["idServices"] == null
            ? []
            : List<int>.from(json["idServices"]!.map((x) => x)),
        servicesName: json["servicesName"] == null
            ? []
            : List<String>.from(json["servicesName"]!.map((x) => x)),
        servicePrice: json["servicePrice"] == null
            ? []
            : List<ServicePrice>.from(
                json["servicePrice"]!.map((x) => ServicePrice.fromJson(x))),
        result: json["result"],
        statusService: json["statusService"],
        statusBooking: json["statusBooking"],
        yourQueue: json["yourQueue"],
        queueNow: json["queueNow"],
        queueQuota: json["queueQuota"],
        totalBooking: json["totalBooking"],
        midtransResponse: json["midtransResponse"] == null
            ? null
            : MidtransResponse.fromJson(json["midtransResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idClinic": idClinic,
        "patientName": patientName,
        "clinicName": clinicName,
        "clinicPhoto": clinicPhoto,
        "clinicAddress": clinicAddress,
        "idDoctor": idDoctor,
        "doctorName": doctorName,
        "doctorSpecialization": doctorSpecialization,
        "doctorPhoto": doctorPhoto,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "idServices": idServices == null
            ? []
            : List<dynamic>.from(idServices!.map((x) => x)),
        "servicesName": servicesName == null
            ? []
            : List<dynamic>.from(servicesName!.map((x) => x)),
        "servicePrice": servicePrice == null
            ? []
            : List<dynamic>.from(servicePrice!.map((x) => x.toJson())),
        "result": result,
        "statusService": statusService,
        "statusBooking": statusBooking,
        "yourQueue": yourQueue,
        "queueNow": queueNow,
        "queueQuota": queueQuota,
        "totalBooking": totalBooking,
        "midtransResponse": midtransResponse?.toJson(),
      };
}

class MidtransResponse {
  String? statusCode;

  MidtransResponse({
    this.statusCode,
  });

  factory MidtransResponse.fromJson(Map<String, dynamic> json) =>
      MidtransResponse(
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
      };
}

class ServicePrice {
  String? serviceName;
  String? price;

  ServicePrice({
    this.serviceName,
    this.price,
  });

  factory ServicePrice.fromJson(Map<String, dynamic> json) => ServicePrice(
        serviceName: json["serviceName"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "price": price,
      };
}

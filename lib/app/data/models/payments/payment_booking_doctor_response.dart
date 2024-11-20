class PaymentBookingDoctorResponse {
  bool? status;
  String? message;
  Data? data;

  PaymentBookingDoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentBookingDoctorResponse.fromJson(Map<String, dynamic> json) =>
      PaymentBookingDoctorResponse(
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
  int? idPatient;
  String? orderId;
  String? name;
  ServiceDetails? serviceDetails;
  String? transactionStatus;
  MidtransResponse? midtransResponse;
  int? yourQueue;
  int? queueNow;
  int? queueQuota;
  int? totalBooking;
  String? date;
  String? startTime;
  String? endTime;
  List<String>? servicesName;

  Data({
    this.idPatient,
    this.orderId,
    this.name,
    this.serviceDetails,
    this.transactionStatus,
    this.midtransResponse,
    this.yourQueue,
    this.queueQuota,
    this.queueNow,
    this.totalBooking,
    this.date,
    this.startTime,
    this.endTime,
    this.servicesName
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idPatient: json["idPatient"],
    orderId: json["orderId"],
    name: json["name"],
    serviceDetails: json["serviceDetails"] == null
        ? null
        : ServiceDetails.fromJson(json["serviceDetails"]),
    transactionStatus: json["transactionStatus"],
    midtransResponse: json["midtransResponse"] == null
        ? null
        : MidtransResponse.fromJson(json["midtransResponse"]),
    yourQueue: json["yourQueue"],
    queueQuota: json["queueQuota"],
    queueNow: json["queueNow"],
    totalBooking: json["totalBooking"],
    date: json['date'],
    startTime: json['startTime'],
    endTime: json['endTime'],
    servicesName: json["servicesName"] == null ? [] : List<String>.from(json["servicesName"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
        "idPatient": idPatient,
        "orderId": orderId,
        "name": name,
        "serviceDetails": serviceDetails?.toJson(),
        "transactionStatus": transactionStatus,
        "midtransResponse": midtransResponse?.toJson(),
      };
}

class MidtransResponse {
  String? statusCode;
  String? statusMessage;
  String? transactionId;
  String? orderId;
  String? merchantId;
  String? grossAmount;
  String? currency;
  String? paymentType;
  DateTime? transactionTime;
  String? transactionStatus;
  String? fraudStatus;
  String? billKey;
  String? billerCode;
  List<VaNumber>? vaNumbers;
  DateTime? expiryTime;

  MidtransResponse({
    this.statusCode,
    this.statusMessage,
    this.transactionId,
    this.orderId,
    this.merchantId,
    this.grossAmount,
    this.currency,
    this.paymentType,
    this.transactionTime,
    this.transactionStatus,
    this.fraudStatus,
    this.billKey,
    this.billerCode,
    this.vaNumbers,
    this.expiryTime,
  });

  factory MidtransResponse.fromJson(Map<String, dynamic> json) =>
      MidtransResponse(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        billKey: json["bill_key"],
        billerCode: json["biller_code"],
        vaNumbers: json["va_numbers"] == null
            ? []
            : List<VaNumber>.from(
                json["va_numbers"]!.map((x) => VaNumber.fromJson(x))),
        expiryTime: json["expiry_time"] == null
            ? null
            : DateTime.parse(json["expiry_time"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime?.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "bill_key": billKey,
        "biller_code": billerCode,
        "va_numbers": vaNumbers == null
            ? []
            : List<dynamic>.from(vaNumbers!.map((x) => x.toJson())),
        "expiry_time": expiryTime?.toIso8601String(),
      };
}

class VaNumber {
  String? bank;
  String? vaNumber;

  VaNumber({
    this.bank,
    this.vaNumber,
  });

  factory VaNumber.fromJson(Map<String, dynamic> json) => VaNumber(
        bank: json["bank"],
        vaNumber: json["va_number"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "va_number": vaNumber,
      };
}

class ServiceDetails {
  int? idClinic;
  int? idDoctor;
  int? idPatient;
  String? clinicName;
  String? doctorName;
  String? doctorSpecialization;
  DateTime? date;
  String? startTime;
  String? endTime;
  List<int>? idServices;
  List<String>? servicesName;
  List<String>? servicesPrice;
  String? statusService;
  String? statusBooking;

  ServiceDetails({
    this.idClinic,
    this.idDoctor,
    this.idPatient,
    this.clinicName,
    this.doctorName,
    this.doctorSpecialization,
    this.date,
    this.startTime,
    this.endTime,
    this.idServices,
    this.servicesName,
    this.servicesPrice,
    this.statusService,
    this.statusBooking,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        idClinic: json["idClinic"],
        idDoctor: json["idDoctor"],
        idPatient: json["idPatient"],
        clinicName: json["clinicName"],
        doctorName: json["doctorName"],
        doctorSpecialization: json["doctorSpecialization"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        idServices: json["idServices"] == null
            ? []
            : List<int>.from(json["idServices"]!.map((x) => x)),
        servicesName: json["servicesName"] == null
            ? []
            : List<String>.from(json["servicesName"]!.map((x) => x)),
        servicesPrice: json["servicesPrice"] == null
            ? []
            : List<String>.from(json["servicesPrice"]!.map((x) => x)),
        statusService: json["statusService"],
        statusBooking: json["statusBooking"],
      );

  Map<String, dynamic> toJson() => {
        "idClinic": idClinic,
        "idDoctor": idDoctor,
        "idPatient": idPatient,
        "clinicName": clinicName,
        "doctorName": doctorName,
        "doctorSpecialization": doctorSpecialization,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "idServices": idServices == null
            ? []
            : List<dynamic>.from(idServices!.map((x) => x)),
        "servicesName": servicesName == null
            ? []
            : List<dynamic>.from(servicesName!.map((x) => x)),
        "servicesPrice": servicesPrice == null
            ? []
            : List<dynamic>.from(servicesPrice!.map((x) => x)),
        "statusService": statusService,
        "statusBooking": statusBooking,
      };
}

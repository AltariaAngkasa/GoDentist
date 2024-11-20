class HistoryBookingClinicResponse {
  bool? status;
  String? message;
  List<HistoryBookingClinicResponseData>? data;

  HistoryBookingClinicResponse({
    this.status,
    this.message,
    this.data,
  });

  factory HistoryBookingClinicResponse.fromJson(Map<String, dynamic> json) =>
      HistoryBookingClinicResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HistoryBookingClinicResponseData>.from(json["data"]!.map((x) => HistoryBookingClinicResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HistoryBookingClinicResponseData {
  int? id;
  int? idPatient;
  String? orderId;
  String? name;
  ServiceDetails? serviceDetails;
  MidtransResponse? midtransResponse;
  String? typeService;
  String? transactionStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  HistoryBookingClinicResponseData({
    this.id,
    this.idPatient,
    this.orderId,
    this.name,
    this.serviceDetails,
    this.midtransResponse,
    this.typeService,
    this.transactionStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryBookingClinicResponseData.fromJson(Map<String, dynamic> json) => HistoryBookingClinicResponseData(
        id: json["id"],
        idPatient: json["idPatient"],
        orderId: json["orderId"],
        name: json["name"],
        serviceDetails: json["serviceDetails"] == null
            ? null
            : ServiceDetails.fromJson(json["serviceDetails"]),
        midtransResponse: json["midtransResponse"] == null
            ? null
            : MidtransResponse.fromJson(json["midtransResponse"]),
        typeService: json["typeService"],
        transactionStatus: json["transactionStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idPatient": idPatient,
        "orderId": orderId,
        "name": name,
        "serviceDetails": serviceDetails?.toJson(),
        "midtransResponse": midtransResponse?.toJson(),
        "typeService": typeService,
        "transactionStatus": transactionStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class MidtransResponse {
  String? statusCode;
  String? transactionId;
  String? grossAmount;
  String? currency;
  String? orderId;
  String? paymentType;
  String? signatureKey;
  String? transactionStatus;
  String? fraudStatus;
  String? statusMessage;
  String? merchantId;
  List<VaNumber>? vaNumbers;
  List<dynamic>? paymentAmounts;
  DateTime? transactionTime;
  DateTime? settlementTime;
  DateTime? expiryTime;

  MidtransResponse({
    this.statusCode,
    this.transactionId,
    this.grossAmount,
    this.currency,
    this.orderId,
    this.paymentType,
    this.signatureKey,
    this.transactionStatus,
    this.fraudStatus,
    this.statusMessage,
    this.merchantId,
    this.vaNumbers,
    this.paymentAmounts,
    this.transactionTime,
    this.settlementTime,
    this.expiryTime,
  });

  factory MidtransResponse.fromJson(Map<String, dynamic> json) =>
      MidtransResponse(
        statusCode: json["status_code"],
        transactionId: json["transaction_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        orderId: json["order_id"],
        paymentType: json["payment_type"],
        signatureKey: json["signature_key"],
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        statusMessage: json["status_message"],
        merchantId: json["merchant_id"],
        vaNumbers: json["va_numbers"] == null
            ? []
            : List<VaNumber>.from(
                json["va_numbers"]!.map((x) => VaNumber.fromJson(x))),
        paymentAmounts: json["payment_amounts"] == null
            ? []
            : List<dynamic>.from(json["payment_amounts"]!.map((x) => x)),
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        settlementTime: json["settlement_time"] == null
            ? null
            : DateTime.parse(json["settlement_time"]),
        expiryTime: json["expiry_time"] == null
            ? null
            : DateTime.parse(json["expiry_time"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "transaction_id": transactionId,
        "gross_amount": grossAmount,
        "currency": currency,
        "order_id": orderId,
        "payment_type": paymentType,
        "signature_key": signatureKey,
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "status_message": statusMessage,
        "merchant_id": merchantId,
        "va_numbers": vaNumbers == null
            ? []
            : List<dynamic>.from(vaNumbers!.map((x) => x.toJson())),
        "payment_amounts": paymentAmounts == null
            ? []
            : List<dynamic>.from(paymentAmounts!.map((x) => x)),
        "transaction_time": transactionTime?.toIso8601String(),
        "settlement_time": settlementTime?.toIso8601String(),
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
  String? clinicName;
  String? doctorName;
  String? doctorSpecialization;
  String? photo;
  DateTime? date;
  String? startTime;
  String? endTime;
  List<int>? idServices;
  List<String>? servicesName;
  List<String>? servicesPrice;
  String? statusService;
  String? statusBooking;

  ServiceDetails({
    this.clinicName,
    this.doctorName,
    this.photo,
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
        clinicName: json["clinicName"],
        doctorName: json["doctorName"],
        doctorSpecialization: json["doctorSpecialization"],
        photo: json['photo'],
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

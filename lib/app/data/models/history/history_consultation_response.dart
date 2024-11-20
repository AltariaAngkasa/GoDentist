class HistoryConsultationResponse {
  bool? status;
  String? message;
  List<HistoryConsultationData>? data;

  HistoryConsultationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory HistoryConsultationResponse.fromJson(Map<String, dynamic> json) =>
      HistoryConsultationResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HistoryConsultationData>.from(json["data"]!.map((x) => HistoryConsultationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HistoryConsultationData {
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

  HistoryConsultationData({
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

  factory HistoryConsultationData.fromJson(Map<String, dynamic> json) => HistoryConsultationData(
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
  List<PaymentAmount>? paymentAmounts;
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
            : List<PaymentAmount>.from(
                json["payment_amounts"]!.map((x) => PaymentAmount.fromJson(x))),
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
            : List<dynamic>.from(paymentAmounts!.map((x) => x.toJson())),
        "transaction_time": transactionTime?.toIso8601String(),
        "settlement_time": settlementTime?.toIso8601String(),
        "expiry_time": expiryTime?.toIso8601String(),
      };
}

class PaymentAmount {
  String? amount;
  DateTime? paidAt;

  PaymentAmount({
    this.amount,
    this.paidAt,
  });

  factory PaymentAmount.fromJson(Map<String, dynamic> json) => PaymentAmount(
        amount: json["amount"],
        paidAt:
            json["paid_at"] == null ? null : DateTime.parse(json["paid_at"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "paid_at": paidAt?.toIso8601String(),
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
  int? id;
  String? name;
  String? consultationPrice;
  String? photo;

  ServiceDetails({
    this.id,
    this.name,
    this.consultationPrice,
    this.photo
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
    id: json["id"],
    name: json["name"],
    consultationPrice: json["consultationPrice"],
    photo: json['photo']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "consultationPrice": consultationPrice,
  };
}

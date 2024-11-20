class PaymentConsultationResponse {
  bool? status;
  String? message;
  PaymentConsultationData? data;

  PaymentConsultationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentConsultationResponse.fromJson(Map<String, dynamic> json) =>
      PaymentConsultationResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : PaymentConsultationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class PaymentConsultationData {
  int? idPatient;
  String? orderId;
  String? name;
  ServiceDetails? serviceDetails;
  String? transactionStatus;
  MidtransResponse? midtransResponse;

  PaymentConsultationData({
    this.idPatient,
    this.orderId,
    this.name,
    this.serviceDetails,
    this.transactionStatus,
    this.midtransResponse,
  });

  factory PaymentConsultationData.fromJson(Map<String, dynamic> json) => PaymentConsultationData(
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
  int? id;
  String? name;
  String? consultationPrice;

  ServiceDetails({
    this.id,
    this.name,
    this.consultationPrice,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        id: json["id"],
        name: json["name"],
        consultationPrice: json["consultationPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "consultationPrice": consultationPrice,
      };
}

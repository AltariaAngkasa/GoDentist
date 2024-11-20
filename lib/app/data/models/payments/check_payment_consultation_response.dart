class CheckPaymentConsultationResponse {
  bool? status;
  String? message;
  Data? data;

  CheckPaymentConsultationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CheckPaymentConsultationResponse.fromJson(
          Map<String, dynamic> json) =>
      CheckPaymentConsultationResponse(
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
  MidtransResponse? midtransResponse;

  Data({
    this.midtransResponse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        midtransResponse: json["midtransResponse"] == null
            ? null
            : MidtransResponse.fromJson(json["midtransResponse"]),
      );

  Map<String, dynamic> toJson() => {
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
  String? acquirer;

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
    this.acquirer,
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
        acquirer: json["acquirer"],
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
        "acquirer": acquirer,
      };
}

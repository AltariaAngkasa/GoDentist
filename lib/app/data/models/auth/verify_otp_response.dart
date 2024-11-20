class VerifyOTPResponse {
  bool? status;
  String? message;
  String? data;

  VerifyOTPResponse({
    this.status,
    this.message,
    this.data,
  });

  factory VerifyOTPResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOTPResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}

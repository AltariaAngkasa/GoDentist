class ForgotPasswordResponse {
  bool? status;
  String? message;
  String? detail;

  ForgotPasswordResponse({
    this.status,
    this.message,
    this.detail,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        status: json["status"],
        message: json["message"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "detail": detail,
      };
}

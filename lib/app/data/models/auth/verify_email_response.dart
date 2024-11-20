class VerifyEmailResponse {
  bool? status;
  String? message;
  String? data;
  String? error;

  VerifyEmailResponse({
    this.status,
    this.message,
    this.data,
    this.error,
  });

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) =>
      VerifyEmailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "error": error,
      };
}

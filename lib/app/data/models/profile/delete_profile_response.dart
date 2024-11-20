class DeleteProfileResponse {
  bool? status;
  String? message;

  DeleteProfileResponse({
    this.status,
    this.message,
  });

  factory DeleteProfileResponse.fromJson(Map<String, dynamic> json) =>
      DeleteProfileResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

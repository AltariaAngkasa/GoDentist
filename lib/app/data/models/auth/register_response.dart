class RegisterResponse {
  bool? status;
  String? message;
  String? description;
  String? error;

  RegisterResponse({
    this.status,
    this.message,
    this.description,
    this.error,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"],
        message: json["message"],
        description: json["description"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "description": description,
        "error": error,
      };
}

class ChatResponse {
  late String idPatient;
  late String text;
  late int timestamp;
  bool? isDoctor;
  String? imageUrl; // Tambahkan field untuk URL gambar

  ChatResponse({
    required this.idPatient,
    required this.text,
    required this.timestamp,
    this.isDoctor,
    this.imageUrl, // Ini bersifat opsional karena mungkin tidak selalu ada gambar
  });

  ChatResponse.fromJson(Map<String, dynamic> json) {
    idPatient = json['idPatient'];
    text = json['text'];
    timestamp = json['timestamp'];
    isDoctor = json['isDoctor'];
    imageUrl = json['imageUrl']; // Tambahkan ini untuk deserialisasi
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPatient'] = idPatient;
    data['text'] = text;
    data['timestamp'] = timestamp;
    if (isDoctor != null) data['isDoctor'] = isDoctor;
    if (imageUrl != null) data['imageUrl'] = imageUrl; // Serikan hanya jika imageUrl tidak null

    return data;
  }
}

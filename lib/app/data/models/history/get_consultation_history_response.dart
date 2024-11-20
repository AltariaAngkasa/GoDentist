
class GetConsultationHistoryResponse {

  GetConsultationHistoryResponse({
      bool? status, 
      String? message, 
      List<GetConsultationHistoryResponseData>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetConsultationHistoryResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetConsultationHistoryResponseData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetConsultationHistoryResponseData>? _data;

GetConsultationHistoryResponse copyWith({
  bool? status,
  String? message,
  List<GetConsultationHistoryResponseData>? data,
}) => GetConsultationHistoryResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<GetConsultationHistoryResponseData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class GetConsultationHistoryResponseData {

  String? _idRoomChat;
  String? get idRoomChat => _idRoomChat;

  GetConsultationHistoryResponseData({String? idRoomChat,}){
    _idRoomChat = idRoomChat;
  }

  GetConsultationHistoryResponseData.fromJson(dynamic json) {
    _idRoomChat = json['idRoomChat'];
  }
  GetConsultationHistoryResponseData copyWith({String? idRoomChat}) => GetConsultationHistoryResponseData(  idRoomChat: idRoomChat ?? _idRoomChat);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idRoomChat'] = _idRoomChat;
    return map;
  }

}
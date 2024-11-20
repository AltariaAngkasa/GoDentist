import 'package:GoDentist/app/data/models/chats/chat_response.dart';
import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';
import 'package:GoDentist/app/data/models/doctor/search_doctor_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CDoctor extends CCommon {
  final apiService = ApiService();

  final Rx<DoctorResponse> _doctorResponse = DoctorResponse().obs;
  DoctorResponse get doctorResponse => _doctorResponse.value;
  set doctorResponse(DoctorResponse newValue) {
    _doctorResponse.value = newValue;
  }

  final Rx<SearchDoctorResponse> _searchDoctorResponse = SearchDoctorResponse().obs;
  SearchDoctorResponse get searchDoctorResponse => _searchDoctorResponse.value;
  set searchDoctorResponse(SearchDoctorResponse newValue) {
    _searchDoctorResponse.value = newValue;
  }

  final TextEditingController searchQuery = TextEditingController();
  // Map<String, List<ChatResponse>> chatMap = {};

  Future getDoctor() async {
    isFetching = true;
    final result = await apiService.getDoctor();
    result.when(
      success: (data) {
        doctorResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = doctorResponse.message ?? "Successfull get doctor";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future searchDoctor(String name) async {
    isFetching = true;
    final result = await apiService.searchDoctor(name);
    result.when(
      success: (data) {
        searchDoctorResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = searchDoctorResponse.message ?? "Successfull search doctor";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  // Future generateChatRoom() async {
  //   DatabaseReference chatRoomRef =
  //       FirebaseDatabase.instance.ref().child('chatRoom');

  //   String? chatRoomId = chatRoomRef.push().key;

  //   Map<String, dynamic> chatRoomData = {
  //     'doctorId': doctorResponse.data![1].id,
  //     'doctorName': doctorResponse.data![1].name,
  //     'doctorPhoto': doctorResponse.data![1].photo,
  //     'idPatient': cLogin.loginResponse.data?.id,
  //     'patientName': cHome.profileResponse.data?.name,
  //   };

  //   chatRoomRef.child(chatRoomId!).set(chatRoomData).then((_) {
  //     print('Chat room berhasil dibuat dengan ID: $chatRoomId');
  //   }).catchError((error) {
  //     print('Gagal membuat chat room: $error');
  //   });
  // }

  // Future getChatData() async {
  //   DatabaseReference messagesRef =
  //       FirebaseDatabase.instance.ref().child('messages');

  //   messagesRef.onValue.listen((event) {
  //     chatMap.clear();

  //     dynamic messages = event.snapshot.value;
  //     if (messages != null) {
  //       messages.forEach((chatRoomId, messageData) {
  //         messageData.forEach((key, value) {
  //           if (value['timestamp'] != null) {
  //             ChatResponse chat = ChatResponse(
  //               idPatient: value['idPatient'],
  //               text: value['text'],
  //               timestamp: value['timestamp'],
  //             );
  //             if (!chatMap.containsKey(chatRoomId)) {
  //               chatMap[chatRoomId] = [];
  //             }
  //             chatMap[chatRoomId]!.add(chat);
  //           }
  //         });
  //       });
  //       // Panggil update di GetBuilder / GetX widget di mana Anda ingin menampilkan data chat
  //       update();
  //     }
  //   });
  // }

  @override
  void onInit() async {
    super.onInit();
    await getDoctor();
    // await generateChatRoom();
    // await getChatData();
  }
}

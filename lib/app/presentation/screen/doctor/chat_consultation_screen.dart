import 'dart:async';
import 'dart:io';
import 'package:GoDentist/app/data/models/chats/chat_response.dart';
import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';
import 'package:GoDentist/app/data/models/payments/payment_consultation_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_history.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:GoDentist/app/presentation/screen/doctor/widgets/choose_image_source_dialog.dart';
import 'package:GoDentist/app/presentation/screen/main/main_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatConsultationScreen extends StatefulWidget {
  final DoctorResponseData doctor;
  final PaymentConsultationData paymentConsultationData;
  const ChatConsultationScreen({required this.doctor, required this.paymentConsultationData, Key? key}) : super(key: key);

  @override
  State<ChatConsultationScreen> createState() => _ChatConsultationScreenState();
}

class _ChatConsultationScreenState extends State<ChatConsultationScreen> {

  final cHome = Get.put(CHome());
  final cLogin = CLogin.instance;
  final cHistory = Get.put(CHistory());

  Map<String, List<ChatResponse>> chatMap = {};
  TextEditingController textEditingController = TextEditingController();

  //yg baru iu09\yh
  Timer? _chatTimer;
  int _remainingTime = 30 * 60; // Waktu dalam detik (30 menit)

  @override
  void initState() {
    super.initState();
    generateChatRoom();
    startChatCountdown(); // Memulai countdown durasi chat
  }

  @override
  void dispose() {
    _chatTimer?.cancel(); // Membatalkan timer ketika state di dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        // Get.back();
                        _onBackPressed(context);
                      },
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.doctor.photo ?? "",
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.name ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "online",
                          style: TextStyle(
                            color: Color(0xff8189A2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              buildTimer(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 50),
                  itemCount: chatMap.length,
                  itemBuilder: (context, index) {
                    String chatRoomId = chatMap.keys.toList()[index];
                    List<ChatResponse> chats = chatMap[chatRoomId] ?? [];
                    chats.sort((a, b) => a.timestamp.compareTo(b.timestamp));
                    return Column(
                      children: chats.skip(1).map((chat) {
                        if (chat.imageUrl != null) {
                          return imageMessageBubble(
                            context,
                            imageUrl: chat.imageUrl!,
                            isUserMessage: chat.isDoctor == null || chat.isDoctor == false,
                          );
                        }
                        return textMessageBubble(
                          context,
                          text: chat.text,
                          isUserMessage: chat.isDoctor == null || chat.isDoctor == false,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan pesan disini',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo),
                      onPressed: () {
                        uploadImage(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty && chatMap.isNotEmpty) {
                          _sendButtonPressed(textEditingController.text);
                        } else {
                          debugPrint('Tidak ada pesan untuk dikirim atau chat room tidak tersedia.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimer() {
    final minutes = _remainingTime ~/ 60;
    final seconds = _remainingTime % 60;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'Waktu tersisa: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget textMessageBubble(BuildContext context, {required String text, required bool isUserMessage}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Align(
        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: isUserMessage ? Color(0xffC2CDF3) : Color(0xff29439A),
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isUserMessage ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget untuk pesan gambar
  Widget imageMessageBubble(BuildContext context, {required String imageUrl, required bool isUserMessage}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Align(
        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: isUserMessage ? Color(0xffC2CDF3) : Color(0xff29439A),
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      'Failed to load image',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> generateChatRoom() async {
    DatabaseReference chatRoomRef =
    FirebaseDatabase.instance.ref().child('chatRoom');
    String? chatRoomId = chatRoomRef.push().key;
    int startAt = DateTime.now().millisecondsSinceEpoch;
    bool status = true;

    Map<String, dynamic> chatRoomData = {
      'doctorId': widget.doctor.id.toString(),
      'doctorName': widget.doctor.name,
      'doctorPhoto': widget.doctor.photo,
      'idPatient': cLogin.loginResponse.data?.id,
      'patientName': cHome.profileResponse.data?.name,
      'startAt': startAt,
      'status': status,
    };

    // Simpan data chat room di cabang 'chatRoom'
    chatRoomRef.child(chatRoomId!).set(chatRoomData).then((_) {
      cHistory.createHistoryChat(orderId: widget.paymentConsultationData.orderId ?? "", idRoomChat: chatRoomId);
      // Buat instance baru di cabang 'messages' dengan nama yang sama
      DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('messages').child(chatRoomId);
      Map<String, dynamic> messageData = {
        'idPatient': cLogin.loginResponse.data?.id,
        'text': "Halo dok",
        'timestamp': ServerValue.timestamp,
        'status': true,
      };
      messagesRef.push().set(messageData).then((_) {
        startListeningToMessages(chatRoomId);
      }).catchError((error) {
        debugPrint('Gagal menambahkan pesan selamat datang: $error');
      });
    }).catchError((error) {
      debugPrint('Gagal membuat chat room: $error');
    });
  }

  void startListeningToMessages(String chatRoomId) {
    DatabaseReference messagesRef =
    FirebaseDatabase.instance.ref().child('messages').child(chatRoomId);

    messagesRef.onValue.listen((event) {
      chatMap.clear();

      dynamic messages = event.snapshot.value;
      if (messages != null) {
        messages.forEach((key, messageData) {
          ChatResponse chat = ChatResponse(
              idPatient: key,
              text: messageData['text'],
              timestamp: messageData['timestamp'],
              imageUrl: messageData['imageUrl'],
              isDoctor: messageData['isDoctor']
          );
          chatMap[chatRoomId] ??= [];
          chatMap[chatRoomId]!.add(chat);
        });
        setState(() {});
      }
    });
  }

  void _sendButtonPressed(String text) {
    if (text.isNotEmpty) {
      if (chatMap.isNotEmpty) {
        String chatRoomId = chatMap.keys.first;
        sendMessageToRoom(chatRoomId, text);
        textEditingController.clear();
      } else {
        debugPrint('Tidak ada pesan untuk dikirim atau chat room tidak tersedia.');
      }
    } else {
      debugPrint('Teks pesan tidak boleh kosong.');
    }
  }

  Future<void> updateChatRoomStatus(bool status) async {
    String chatRoomId = chatMap.keys.first;
    DatabaseReference chatRoomRef = FirebaseDatabase.instance.ref().child('chatRoom').child(chatRoomId);
    await chatRoomRef.update({'status': status});
  }

  void startChatCountdown() {
    _chatTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        updateChatRoomStatus(false); // Mengubah status menjadi false
      }
    });
  }

  void sendMessageToRoom(String chatRoomId, String text, [String imageUrl = '']) {
    if(_remainingTime > 0) {
      DatabaseReference messagesRef =
      FirebaseDatabase.instance.ref().child('messages').child(chatRoomId);

      Map<String, dynamic> messageData = {
        'idPatient': cLogin.loginResponse.data?.id,
        'text': text,
        'timestamp': ServerValue.timestamp,
        'status': true,
      };
      if (imageUrl.isNotEmpty) messageData['imageUrl'] = imageUrl; // Menambahkan URL gambar jika ada

      messagesRef.push().set(messageData).then((_) {
        debugPrint('Pesan berhasil dikirim');
      }).catchError((error) {
        debugPrint('Gagal mengirim pesan: $error');
      });
    } else {
      Get.snackbar(
        "Perhatian",
        "Waktu konsultasi telah habis !",
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
      );
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if(_remainingTime > 0) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (context) {
          return ChooseImageSourceDialog(
            onSelected: (source) {
              Navigator.of(context).pop();
              sendImage(source == ImageSourceEnum.GALLERY ? ImageSource.gallery : ImageSource.camera);
            },
          );
        },
      );
    }
    else {
      Get.snackbar(
        "Perhatian",
        "Waktu konsultasi telah habis !",
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
      );
    }
  }

  Future<void> sendImage(ImageSource source) async {
    // Ambil gambar menggunakan image_picker atau metode lainnya
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String fileName = basename(imageFile.path);
      Reference storageRef =
      FirebaseStorage.instance.ref().child('images/$fileName');

      try {
        // Mulai pengunggahan
        await storageRef.putFile(imageFile).then((_) async {
          final imageUrl = await storageRef.getDownloadURL();
          sendMessageToRoom(chatMap.keys.first, '', imageUrl);
          setState(() {}); // Refresh the UI after setting the image URL
        });
      } catch (e) {
        // Handle errors
        debugPrint('Gagal mengunggah gambar: $e');
      }
    }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (_remainingTime > 0) {
      // Jika waktu chat masih berlangsung
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah kamu ingin mengakhiri chat?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
                child: Text('Ya'),
                onPressed: () {
                  Get.offAll(MainScreen());
                  Get.back();
                }),
          ],
        ),
      );
      return result ?? false;
    }
    return true;
  }

}

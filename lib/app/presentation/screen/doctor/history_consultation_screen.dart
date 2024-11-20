import 'package:GoDentist/app/data/models/history/history_consultation_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_history.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/chats/chat_response.dart';

class HistoryConsultationScreen extends StatefulWidget {
  final HistoryConsultationData data;

  const HistoryConsultationScreen({required this.data, super.key});

  @override
  State<HistoryConsultationScreen> createState() => _HistoryConsultationScreenState();
}

class _HistoryConsultationScreenState extends State<HistoryConsultationScreen> {
  
  final cHistory = Get.put(CHistory());
  Map<String, List<ChatResponse>> chatMap = {};
  bool? isAvailable;

  late Worker loadHistory;

  @override
  void initState() {
    cHistory.getConsultationHistory(orderId: widget.data.orderId!);
    loadHistory = ever(cHistory.consultationHistory, (value) {
      final id = cHistory.consultationHistoryValue.data?.firstOrNull?.idRoomChat;
      debugPrint("ID : $id");
      if(id != null) {
        if(id.isNotEmpty) {
          isAvailable = true;
          startListeningToMessages(id);
        } else {
          isAvailable = false;
        }
      } else {
        setState(() {
          isAvailable = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loadHistory.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Riwayat Konsultasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Obx(() => cHistory.isFetching
          ? Center(child: CircularProgressIndicator())
          : Builder(
        builder: (context) {
          if(isAvailable == false) {
            return Center(
              child: Text("Riwayat tidak tersedia"),
            );
          }
          return content(context);
        },
      )
      ),
    );
  }

  Widget content(BuildContext context) {
    return ListView.builder(
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
    );
  }

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

  void startListeningToMessages(String chatRoomId) {
    debugPrint("CHAT ROOM ID : $chatRoomId");
    DatabaseReference messagesRef = FirebaseDatabase.instance.ref().child('messages').child(chatRoomId);

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

}

import 'package:GoDentist/app/common/routes/app_routes.dart';
import 'package:GoDentist/app/data/sessions/session.dart';
import 'package:GoDentist/app/service/firebase_service.dart';
import 'package:GoDentist/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID', null);
  await initFirebase();
  await NotificationService().init();
  String? token = await TokenManager.getToken();
  runApp(MyApp(
    isLoggedIn: token != null,
  ));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("NOTIFICATION SHOW : ${message.data.toString()} ${message.notification?.toMap()}");
      await NotificationService.showNotification(message.notification);
    });
    getFCMToken().then((value) {
      debugPrint("FCM TOKEN : $value");
    });
    Permission.notification.isDenied.then((isDenied) async {
      if(isDenied) await Permission.notification.request();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetMaterialApp(
        title: 'Go Dentiest',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: AppPages.initial,
        initialRoute: widget.isLoggedIn ? AppPages.initial : AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}

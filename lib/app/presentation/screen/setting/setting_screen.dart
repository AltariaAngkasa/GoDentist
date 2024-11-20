import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/data/sessions/session.dart';
import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:GoDentist/app/presentation/widgets/webview_widget.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cLogin = Get.put(CLogin());

    void launchWhatsApp() async {
      String phoneNumber = "+6281266932773";
      String message = "Halo, saya butuh bantuan.";
      String url = "whatsapp://send?phone=$phoneNumber&text=$message";

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void logout() {
      AlertDialog alert = AlertDialog(
        title: Text("Keluar Aplikasi"),
        content: Container(
          child: Text("Apakah anda yakin keluar dari Aplikasi?"),
        ),
        actions: [
          TextButton(
            child: Text(
              'Batal',
              style: TextStyle(color: ColorConstant.primaryColor),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
              child: Text(
                'Keluar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                cLogin.clearAllData();
                await TokenManager.clearToken();
                Get.offAllNamed(Routes.login);
                Get.deleteAll();
              }),
        ],
      );
      showDialog(context: context, builder: (context) => alert);
      return;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Pengaturan Aplikasi',
          style: TextStyle(
            color: ColorConstant.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Get.to(() => WebViewWidgets(
                    title: 'Tentang Kami',
                    url: 'https://godentist.co.id',
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              height: 85,
              child: Row(
                children: [
                  Text(
                    'Tentang Kami',
                    style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorConstant.blackColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Get.to(() => WebViewWidgets(
                    title: 'Kebijakan Privasi Aplikasi',
                    url: 'https://godentist.co.id',
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              height: 85,
              child: Row(
                children: [
                  Text(
                    'Kebijakan Privasi Aplikasi',
                    style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorConstant.blackColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              launchWhatsApp();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              height: 85,
              child: Row(
                children: [
                  Text(
                    'Pusat Bantuan',
                    style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorConstant.blackColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              logout();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              height: 85,
              child: Row(
                children: [
                  Text(
                    'Keluar',
                    style: TextStyle(
                      color: ColorConstant.redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: ColorConstant.redColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          Text(
            'GoDentist 2.0.2',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

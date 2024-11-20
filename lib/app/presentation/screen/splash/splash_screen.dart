import 'dart:async';
import 'package:GoDentist/app/data/sessions/session.dart';
import 'package:GoDentist/app/utils/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  Future<void> navigateToNextPage() async {
    // Tunggu sampai token tersedia
    await Future.delayed(Duration(seconds: 4));
    String? token = await TokenManager.getToken();
    DateTime? expiryDate = await TokenManager.getTokenExpiryDate();
    // Setelah token tersedia, navigasikan ke halaman yang sesuai
    if (token != null &&
        expiryDate != null &&
        DateTime.now().isBefore(expiryDate)) {
      // Pengguna sudah login
      Get.offAllNamed(Routes.main);
    } else {
      // Pengguna belum login
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageConstant.logo,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

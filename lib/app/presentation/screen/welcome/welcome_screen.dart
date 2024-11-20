import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/routes/app_pages.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/img_welcome.png',
                width: double.infinity,
                // height: MediaQuery.of(context).size.height * 0.5,
              ),
              SizedBox(height: 24),
              Text(
                'Periksa Kesehatan Gigi Secara Berkala,\nJangan Tunggu Sampai Sakit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Button(
                  onPressed: () {
                    Get.toNamed(Routes.login);
                  },
                  color: ColorConstant.primaryColor,
                  text: 'Periksa Gigi Anda Sekarang',
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

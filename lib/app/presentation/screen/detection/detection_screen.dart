import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Deteksi Kesehatan Gigi',
            style: TextStyle(
              color: ColorConstant.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorConstant.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: ListView(
        children: [
          // SizedBox(height: 35),
          Image.asset(
            'assets/images/tutor_take_picture.png',
            height: 650,
            width: 650,
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Button(
              onPressed: () async {
                Get.toNamed(Routes.takePicture);
              },
              color: ColorConstant.primaryColor,
              text: 'Mulai Deteksi Gigi Anda',
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}

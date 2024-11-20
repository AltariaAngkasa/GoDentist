import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_profile.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    final cProfile = Get.put(CProfile());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ganti Password',
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
        ),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TxtFormField(
                color: ColorConstant.primaryColor,
                controller: cProfile.oldPassword,
                keyboardType: TextInputType.visiblePassword,
                label: 'Password Lama',
                showPasswordToggle: true,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password lama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 22),
              TxtFormField(
                color: ColorConstant.primaryColor,
                controller: cProfile.newPassword,
                keyboardType: TextInputType.visiblePassword,
                label: 'Password Baru',
                showPasswordToggle: true,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password baru tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 22),
              TxtFormField(
                color: ColorConstant.primaryColor,
                controller: cProfile.passwordConfirm,
                keyboardType: TextInputType.visiblePassword,
                label: 'Konfirmasi Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              Button(
                onPressed: () async {
                  final isValid = key.currentState!.validate();
                  if (isValid) {
                    key.currentState!.save();
                    await cProfile.changePassword();
                    if (cProfile.isSuccessfull) {
                      Get.offAllNamed(Routes.login);
                    } else {
                      Get.snackbar('Error', cProfile.message);
                    }
                  }
                  cProfile.oldPassword.clear();
                  cProfile.newPassword.clear();
                  cProfile.passwordConfirm.clear();
                },
                color: ColorConstant.primaryColor,
                text: 'Ganti Password',
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

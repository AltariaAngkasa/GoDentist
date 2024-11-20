import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {
  final String email;
  const NewPasswordScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cLogin = Get.put(CLogin());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorConstant.primaryColor,
            size: 22,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Konfirmasi Password Baru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Silahkan masukkan password baru anda',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.primaryColor,
                ),
              ),
              SizedBox(height: 24),
              TxtFormField(
                controller: cLogin.password,
                label: 'Password',
                color: ColorConstant.primaryColor,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                showPasswordToggle: true,
                validator: ((value) =>
                    value!.isEmpty ? 'Password tidak boleh kosong' : null),
              ),
              SizedBox(height: 16),
              TxtFormField(
                controller: cLogin.passwordConfirm,
                label: 'Confirm Password',
                color: ColorConstant.primaryColor,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                showPasswordToggle: true,
                validator: ((value) => value!.isEmpty
                    ? 'Password Konfirmasi tidak boleh kosong'
                    : null),
              ),
              SizedBox(height: 24),
              Button(
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    formKey.currentState!.save();
                    await cLogin.resetPassword(
                      email,
                    );
                    if (cLogin.isSuccessfull) {
                      Get.offAllNamed(Routes.login);
                    } else {
                      Get.snackbar('Error', cLogin.message);
                    }
                  }
                  cLogin.password.clear();
                  cLogin.passwordConfirm.clear();
                },
                color: ColorConstant.primaryColor,
                text: 'Konfirmasi',
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

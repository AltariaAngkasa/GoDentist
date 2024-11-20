import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:GoDentist/app/presentation/screen/auth/new_password_screen.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:GoDentist/app/utils/shared/show_modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cLogin = Get.put(CLogin());

    showModalOTPInput(String email) {
      return ShowModalBottom.otpInput(
        context: context,
        controller: cLogin.otp,
        onCompletedPinInput: (otp) async {
          Get.back();
          await cLogin.verifyOTP(email);
          if (cLogin.isSuccessfull) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPasswordScreen(email: email),
              ),
            );
            cLogin.otp.clear();
          } else {
            Get.snackbar(
              'Gagal',
              'Maaf! OTP Salah',
              backgroundColor: Colors.red[200],
              margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
            );
            cLogin.otp.clear();
          }
        },
      );
    }

    return Obx(
      () => cLogin.isFetching
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
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
                        'Lupa Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Silahkan masukkan email untuk reset ulang password',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                      SizedBox(height: 24),
                      TxtFormField(
                        controller: cLogin.emailForgotPassword,
                        label: 'Email',
                        color: ColorConstant.primaryColor,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: ((value) =>
                            value!.isEmpty ? 'Email tidak boleh kosong' : null),
                      ),
                      SizedBox(height: 24),
                      Button(
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            formKey.currentState!.save();
                            await cLogin.forgetPassword();
                            if (cLogin.isSuccessfull) {
                              showModalOTPInput(
                                  cLogin.emailForgotPassword.text);
                            } else {
                              Get.snackbar(
                                'Gagal',
                                'Maaf! Email Salah',
                                backgroundColor: Colors.red[200],
                                margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                              );
                              cLogin.emailForgotPassword.clear();
                            }
                            cLogin.emailForgotPassword.clear();
                          }
                          cLogin.emailForgotPassword.clear();
                        },
                        color: ColorConstant.primaryColor,
                        text: 'Reset',
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

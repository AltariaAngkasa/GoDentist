import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_register.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmEmailScreen extends StatelessWidget {
  final String email;
  const ConfirmEmailScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cRegister = Get.put(CRegister());
    return Obx(
      () => cRegister.isFetching
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
                    cRegister.otp.clear();
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
                        'Konfirmasi Email',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Silahkan masukkan kode konfirmasi email',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                      SizedBox(height: 24),
                      TxtFormField(
                        controller: cRegister.otp,
                        label: 'Kode',
                        color: ColorConstant.primaryColor,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: ((value) => value!.isEmpty
                            ? 'Kode OTP tidak boleh kosong'
                            : null),
                      ),
                      SizedBox(height: 24),
                      Button(
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            formKey.currentState!.save();
                            await cRegister.verifyEmail(
                              email,
                            );
                            if (cRegister.isSuccessfull) {
                              Get.offAllNamed(Routes.login);
                              cRegister.otp.clear();
                              Get.snackbar(
                                'Berhasil',
                                'Selamat! Konfirmasi email berhasil',
                                backgroundColor: Colors.green[200],
                                margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                              );
                            } else {
                              Get.snackbar(
                                'Gagal',
                                'Maaf! Konfirmasi email gagal',
                                backgroundColor: Colors.red[200],
                                margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                              );
                            }
                          }
                          print(cRegister.otp.text);
                          print(email);
                        },
                        color: ColorConstant.primaryColor,
                        text: 'Daftar',
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

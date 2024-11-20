import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget forgotPassword() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Lupa Password?',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.forgot);
            },
            child: Text(
              'Klik Disini',
              style: TextStyle(
                fontSize: 12,
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    Widget loginGoogle() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            height: 1,
            color: ColorConstant.primaryColor,
          ),
          Text(
            'Atau masuk dengan',
            style: TextStyle(
              fontSize: 14,
              color: ColorConstant.primaryColor,
            ),
          ),
          Container(
            width: 100,
            height: 1,
            color: ColorConstant.primaryColor,
          ),
        ],
      );
    }

    Widget bottomNav() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Dengan masuk atau mendaftar, Anda menyetujui ',
              style: TextStyle(
                fontSize: 11,
                color: ColorConstant.primaryColor,
              ),
              children: [
                TextSpan(
                  text: 'Ketentuan ',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Penggunaan GoDentist',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' dan ',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorConstant.primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'Kebijakan Privasi GoDentist',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    final formKey = GlobalKey<FormState>();
    // final cLogin = Get.put(CLogin());
    final cLogin = CLogin.instance;

    Widget createAccount() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belum punya akun?',
            style: TextStyle(
              fontSize: 14,
              color: ColorConstant.primaryColor,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.register);
              cLogin.email.clear();
              cLogin.password.clear();
            },
            child: Text(
              'Daftar',
              style: TextStyle(
                fontSize: 14,
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 60),
                                Text(
                                  'Selamat Datang',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Masuk untuk melanjutkan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 24),
                                TxtFormField(
                                  controller: cLogin.email,
                                  label: 'Email',
                                  color: ColorConstant.primaryColor,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: ((value) => value!.isEmpty
                                      ? 'Email tidak boleh kosong'
                                      : null),
                                ),
                                SizedBox(height: 24),
                                TxtFormField(
                                  controller: cLogin.password,
                                  label: 'Password',
                                  color: ColorConstant.primaryColor,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: ((value) => value!.isEmpty
                                      ? 'Password tidak boleh kosong'
                                      : null),
                                  showPasswordToggle: true,
                                ),
                                SizedBox(height: 16),
                                forgotPassword(),
                                SizedBox(height: 16),
                                Button(
                                  onPressed: () async {
                                    final isValid =
                                        formKey.currentState!.validate();
                                    if (isValid) {
                                      formKey.currentState!.save();
                                      await cLogin.login();
                                      if (cLogin.isSuccessfull) {
                                        Get.offAllNamed(Routes.main);
                                        Get.snackbar(
                                          'Berhasil',
                                          'Selamat! Kamu berhasil login',
                                          backgroundColor: Colors.green[200],
                                          margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                                        );
                                      } else {
                                        Get.snackbar(
                                          'Gagal',
                                          'Maaf! Email dan Password salah',
                                          backgroundColor: Colors.red[200],
                                          margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                                        );
                                      }
                                    }
                                  },
                                  color: ColorConstant.primaryColor,
                                  text: 'Masuk',
                                  size: 14,
                                ),
                                SizedBox(height: 16),
                                loginGoogle(),
                                SizedBox(height: 16),
                                Image.asset(
                                  'assets/images/ic_google.png',
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(height: 16),
                                createAccount(),
                                SizedBox(height: 32),
                                Spacer(),
                                bottomNav(),
                                SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

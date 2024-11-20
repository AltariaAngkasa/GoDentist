import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_register.dart';
import 'package:GoDentist/app/presentation/screen/auth/confirm_email_screen.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final cRegister = Get.put(CRegister());
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
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
                                  'Senang Mengenal Anda',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Buat akun anda untuk melanjutkan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 24),
                                TxtFormField(
                                  controller: cRegister.name,
                                  label: 'Nama',
                                  color: ColorConstant.primaryColor,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: ((value) => value!.isEmpty
                                      ? 'Nama tidak boleh kosong'
                                      : null),
                                ),
                                SizedBox(height: 24),
                                TxtFormField(
                                  controller: cRegister.noHp,
                                  label: 'Nomor Telepon',
                                  color: ColorConstant.primaryColor,
                                  obscureText: false,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'No Telepone tidak boleh kosong';
                                    } else if (!RegExp(r'^08[0-9]{9,}$')
                                        .hasMatch(value)) {
                                      return 'Nomor Telepon tidak valid';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Jenis Kelamin',
                                    labelStyle: TextStyle(
                                        color: _isFocused
                                            ? ColorConstant.primaryColor
                                            : Colors.grey,
                                        fontWeight: FontWeight.w400),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _isFocused
                                            ? ColorConstant.primaryColor
                                            : Colors.grey,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _isFocused
                                            ? ColorConstant.primaryColor
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  value: cRegister.selectedGender,
                                  items: cRegister.genders.map((gender) {
                                    return DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  onTap: () {
                                    setState(() {
                                      _isFocused = true;
                                    });
                                  },
                                  onChanged: (selectedGender) {
                                    setState(() {
                                      cRegister.selectedGender =
                                          selectedGender.toString();
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? "Jenis Kelamin tidak boleh kosong"
                                      : null,
                                ),
                                SizedBox(height: 16),
                                TxtFormField(
                                  controller: cRegister.email,
                                  label: 'Email',
                                  color: ColorConstant.primaryColor,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email tidak boleh kosong';
                                    } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Format email tidak valid';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                TxtFormField(
                                  controller: cRegister.password,
                                  label: 'Password',
                                  color: ColorConstant.primaryColor,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  showPasswordToggle: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password tidak boleh kosong';
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$')
                                        .hasMatch(value)) {
                                      return 'Password harus terdiri dari minimal 8 karakter, kombinasi angka dan huruf';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                Text('*Password minimal 8 karakter'),
                                SizedBox(height: 6),
                                Text(
                                    '*Password merupakan kombinasi angka dan huruf (tidak boleh memiliki simbol)'),
                                SizedBox(height: 16),
                                Button(
                                  onPressed: () async {
                                    final isValid =
                                        formKey.currentState!.validate();
                                    if (isValid) {
                                      formKey.currentState!.save();
                                      await cRegister.register(
                                        cRegister.selectedGender.toString(),
                                      );
                                      if (cRegister.isSuccessfull) {
                                        // Get.toNamed(Routes.confirmEmail);
                                        Get.to(() => ConfirmEmailScreen(
                                              email: cRegister.email.text,
                                            ));
                                        cRegister.name.clear();
                                        cRegister.noHp.clear();
                                        cRegister.selectedGender!.isEmpty;
                                        // cRegister.email.clear();
                                        cRegister.password.clear();
                                        Get.snackbar(
                                          'Berhasil',
                                          'Selamat! Silahkan konfirmasi email',
                                          backgroundColor: Colors.green[200],
                                          margin: EdgeInsets.only(
                                              bottom: 12, left: 12, right: 12),
                                        );
                                      } else {
                                        Get.snackbar(
                                          'Gagal',
                                          'Maaf! Daftar akun gagal',
                                          backgroundColor: Colors.red[200],
                                          margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                                        );
                                      }
                                    }
                                  },
                                  color: ColorConstant.primaryColor,
                                  text: 'Daftar',
                                  size: 14,
                                ),
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

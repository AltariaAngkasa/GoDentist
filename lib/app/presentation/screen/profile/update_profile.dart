import 'dart:io';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/controllers/c_profile.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/text_field.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:GoDentist/app/utils/shared/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final key = GlobalKey<FormState>();
  final cProfile = Get.put(CProfile());
  final cHome = Get.put(CHome());
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Update Data Profil',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () async {
                    final image = await ImageHelper.selectImageFromGalery();
                    setState(() {
                      cProfile.selectedImage = image;
                    });
                  },
                  child: cProfile.selectedImage == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              cHome.profileResponse.data?.photo ??
                                  "https://via.placeholder.com/150"),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(
                            File(cProfile.selectedImage!.path),
                          ),
                        ),
                ),
                SizedBox(height: 22),
                TxtFormField(
                  color: ColorConstant.primaryColor,
                  controller: cProfile.name,
                  keyboardType: TextInputType.name,
                  label: cHome.profileResponse.data?.name ?? "Nama",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22),
                TxtFormField(
                  color: ColorConstant.primaryColor,
                  controller: cProfile.noHp,
                  keyboardType: TextInputType.number,
                  label: cHome.profileResponse.data?.phoneNumber ??
                      "Nomor Telepon",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor Telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText:
                        cHome.profileResponse.data?.gender ?? "Jenis Kelamin",
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
                  value: cProfile.selectedGender,
                  items: cProfile.genders
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onTap: () {
                    setState(() {
                      _isFocused = true;
                    });
                  },
                  onChanged: (selectedGender) {
                    setState(() {
                      cProfile.selectedGender = selectedGender.toString();
                    });
                  },
                  validator: (value) =>
                      value == null ? "Jenis Kelamin tidak boleh kosong" : null,
                ),
                SizedBox(height: 22),
                TxtFormField(
                  color: ColorConstant.primaryColor,
                  controller: cProfile.email,
                  keyboardType: TextInputType.emailAddress,
                  label: cHome.profileResponse.data?.email ?? "Email",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22),
                Button(
                  onPressed: () async {
                    final isValid = key.currentState!.validate();
                    if (isValid) {
                      key.currentState!.save();
                      await cProfile.updateProfile(
                        cProfile.selectedGender ?? 'Laki-Laki',
                      );
                      if (cProfile.isSuccessfull) {
                        Get.snackbar('Success', cProfile.message);
                      } else {
                        Get.snackbar('Error', cProfile.message);
                      }
                    } else {
                      Get.snackbar('Error', cProfile.message);
                    }
                  },
                  color: ColorConstant.primaryColor,
                  text: 'Simpan',
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

import 'dart:io';

import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/data/models/profile/change_password_response.dart';
import 'package:GoDentist/app/data/models/profile/delete_profile_response.dart';
import 'package:GoDentist/app/data/models/profile/update_profile_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CProfile extends CCommon {
  final ApiService apiService = ApiService();

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController noHp = TextEditingController();
  final TextEditingController email = TextEditingController();

  final cHome = Get.put(CHome());

  final List<String> genders = ['Laki-Laki', 'Perempuan'];
  String? selectedGender; // Nilai default
  XFile? selectedImage;

  final Rx<ChangePasswordResponse> _changePasswordResponse =
      ChangePasswordResponse().obs;
  ChangePasswordResponse get changePasswordResponse =>
      _changePasswordResponse.value;
  set changePasswordResponse(ChangePasswordResponse newValue) {
    _changePasswordResponse.value = newValue;
  }

  final Rx<UpdateProfileResponse> _updateProfileResponse =
      UpdateProfileResponse().obs;
  UpdateProfileResponse get updateProfileResponse =>
      _updateProfileResponse.value;
  set updateProfileResponse(UpdateProfileResponse newValue) {
    _updateProfileResponse.value = newValue;
  }

  final Rx<DeleteProfileResponse> _deleteProfileResponse =
      DeleteProfileResponse().obs;
  DeleteProfileResponse get deleteProfileResponse =>
      _deleteProfileResponse.value;
  set deleteProfileResponse(DeleteProfileResponse newValue) {
    _deleteProfileResponse.value = newValue;
  }

  Future changePassword() async {
    isFetching = true;
    final result = await apiService.changePassword(
      oldPassword.text,
      newPassword.text,
      passwordConfirm.text,
    );
    result.when(
      success: (data) {
        changePasswordResponse = data;
        isSuccessfull = true;
        isFetching = false;
        cHome.getProfile();
        message = "Successfull change password";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future updateProfile(String gender) async {
    isFetching = true;
    final result = await apiService.updateProfile(
      name.text,
      gender,
      email.text,
      noHp.text,
      File(selectedImage!.path),
    );
    result.when(
      success: (data) {
        updateProfileResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = "Successfull update profile";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
        print(error.message);
      },
    );
  }

  Future deleteProfile() async {
    isFetching = true;
    final result = await apiService.deleteProfile();
    result.when(
      success: (data) {
        deleteProfileResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = "Successfull delete profile";
        Get.offAllNamed(Routes.login);
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  // Future<void> updateProfile(String gender) async {
  //   try {
  //     // Menetapkan status fetching ke true
  //     isFetching = true;

  //     // Memeriksa apakah selectedImage tidak null
  //     if (selectedImage != null) {
  //       // Jika selectedImage tidak null, lakukan pemanggilan API untuk memperbarui profil
  //       final result = await apiService.upadteProfile(
  //         name.text,
  //         gender,
  //         email.text,
  //         noHp.text,
  //         // File(selectedImage?.path ??
  //         //     'https://storage.googleapis.com/nst-bucket-dev-env/default/default_avatar.png'),
  //       );

  //       // Memeriksa hasil pemanggilan API
  //       result.when(
  //         success: (data) {
  //           // Jika pemanggilan API berhasil, atur status isSuccessfull menjadi true
  //           isSuccessfull = true;
  //           // Tetapkan response dari API ke updateProfileResponse
  //           updateProfileResponse = data;
  //           // Tetapkan pesan berhasil ke message
  //           message = "Successfull update profile";
  //         },
  //         failure: (error, stackTrace) {
  //           // Jika pemanggilan API gagal, atur status isSuccessfull menjadi false
  //           isSuccessfull = false;
  //           // Tetapkan pesan error dari API ke message
  //           message = error.message;
  //           // Cetak pesan error untuk debug
  //           print(error.message);
  //         },
  //       );
  //     } else {
  //       // Jika selectedImage null, cetak pesan error
  //       print('Error: selectedImage is null');
  //     }
  //   } catch (error) {
  //     // Tangani kesalahan yang mungkin terjadi selama pembaruan profil
  //     print('Error during profile update: $error');
  //     // Atur status isSuccessfull menjadi false
  //     isSuccessfull = false;
  //     // Tetapkan pesan kesalahan umum ke message
  //     message = 'An error occurred while updating the profile.';
  //   } finally {
  //     // Setelah selesai, atur status fetching ke false
  //     isFetching = false;
  //   }
  // }
}

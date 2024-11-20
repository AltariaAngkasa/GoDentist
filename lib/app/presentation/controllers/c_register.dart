import 'package:GoDentist/app/data/models/auth/register_response.dart';
import 'package:GoDentist/app/data/models/auth/verify_email_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CRegister extends CCommon {
  final apiService = ApiService();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController noHp = TextEditingController();
  final TextEditingController otp = TextEditingController();

  final List<String> genders = ['Laki-Laki', 'Perempuan'];
  String? selectedGender; // Nilai default

  final Rx<RegisterResponse> _registerResponse = RegisterResponse().obs;
  RegisterResponse get registerResponse => _registerResponse.value;
  set registerResponse(RegisterResponse newValue) {
    _registerResponse.value = newValue;
  }

  final Rx<VerifyEmailResponse> _verifyEmailResponse =
      VerifyEmailResponse().obs;
  VerifyEmailResponse get verifyEmailResponse => _verifyEmailResponse.value;
  set verifyEmailResponse(VerifyEmailResponse newValue) {
    _verifyEmailResponse.value = newValue;
  }

  Future register(String gender) async {
    isFetching = true;
    final result = await apiService.register(
      name.text,
      gender,
      email.text,
      password.text,
      noHp.text,
    );
    result.when(
      success: (data) {
        isSuccessfull = true;
        isFetching = false;
        registerResponse = data;
        message = registerResponse.message ?? "Successfull register";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future verifyEmail(
    String email,
  ) async {
    isFetching = true;
    final result = await apiService.verifyEmail(
      email,
      otp.text,
    );
    result.when(
      success: (data) {
        isSuccessfull = true;
        isFetching = false;
        verifyEmailResponse = data;
        message = data.message ?? "Successfull verify email";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }
}

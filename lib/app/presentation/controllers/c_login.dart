import 'package:GoDentist/app/data/models/auth/forgot_password_response.dart';
import 'package:GoDentist/app/data/models/auth/login_response.dart';
import 'package:GoDentist/app/data/models/auth/reset_password_response.dart';
import 'package:GoDentist/app/data/models/auth/verify_otp_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/data/sessions/session.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CLogin extends CCommon {
  static CLogin? _instance;
  static CLogin get instance {
    _instance ??= CLogin();
    return _instance!;
  }

  final apiService = ApiService();

  final TextEditingController email = TextEditingController();
  final TextEditingController emailForgotPassword = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  final TextEditingController otp = TextEditingController();

  final Rx<LoginResponse> _loginResponse = LoginResponse().obs;
  LoginResponse get loginResponse => _loginResponse.value;
  set loginResponse(LoginResponse newValue) {
    _loginResponse.value = newValue;
  }

  final Rx<ForgotPasswordResponse> _forgotPassword =
      ForgotPasswordResponse().obs;
  ForgotPasswordResponse get forgotPassword => _forgotPassword.value;
  set forgotPassword(ForgotPasswordResponse newValue) {
    _forgotPassword.value = newValue;
  }

  final Rx<VerifyOTPResponse> _verifyOTPResponse = VerifyOTPResponse().obs;
  VerifyOTPResponse get verifyOTPResponse => _verifyOTPResponse.value;
  set verifyOTPResponse(VerifyOTPResponse newValue) {
    _verifyOTPResponse.value = newValue;
  }

  final Rx<ResetPasswordResponse> _passwordResetResponse =
      ResetPasswordResponse().obs;
  ResetPasswordResponse get passwordResetResponse =>
      _passwordResetResponse.value;
  set passwordResetResponse(ResetPasswordResponse newValue) {
    _passwordResetResponse.value = newValue;
  }

  Future login() async {
    isFetching = true;
    final result = await apiService.login(
      email.text,
      password.text,
    );
    result.when(
      success: (data) {
        loginResponse = data;
        isSuccessfull = true;
        isFetching = false;
        loginResponse = data;
        if (data.data?.token != null && data.data?.expiredIn != null) {
          TokenManager.saveToken(data.data!.token!, data.data!.expiredIn!);
        }
        message = loginResponse.message ?? "Successfull login";
        // print(loginResponse.toJson());
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future forgetPassword(
      // String email,
      ) async {
    isFetching = true;
    final result = await apiService.forgotPassword(
      emailForgotPassword.text,
    );
    result.when(
      success: (data) {
        forgotPassword = data;
        isSuccessfull = true;
        isFetching = false;

        message = data.message ??
            "Successfull forgot password, please check your email";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future verifyOTP(String email) async {
    isFetching = true;
    final result = await apiService.verifyOTP(
      email,
      otp.text,
    );
    result.when(
      success: (data) {
        verifyOTPResponse = data;
        isSuccessfull = true;
        isFetching = false;

        message = data.message ?? "Successfull verify OTP";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future resetPassword(String email) async {
    isFetching = true;
    final result = await apiService.resetPassword(
      email,
      password.text,
      passwordConfirm.text,
    );
    result.when(
      success: (data) {
        passwordResetResponse = data;
        isSuccessfull = true;
        isFetching = false;

        message = data.message ?? "Successfull Reset your Password";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future clearAllData() async {
    await secureStorage.deleteAll();
  }

  @override
  void onInit() {
    super.onInit();
    loginResponse = LoginResponse();
  }
}

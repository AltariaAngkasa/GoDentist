import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class ShowModalBottom {
  static otpInput({
    required BuildContext context,
    required TextEditingController controller,
    required void Function(String)? onCompletedPinInput,
  }) =>
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kami telah mengirimkan OTP ke email anda, silahkan cek email anda',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstant.primaryColor,
                  ),
                ),
                SizedBox(height: 24),
                Pinput(
                  length: 5,
                  controller: controller,
                  onCompleted: onCompletedPinInput,
                ),
              ],
            ),
          );
        },
      );
}

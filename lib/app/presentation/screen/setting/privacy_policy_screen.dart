import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Kebijakan Privasi',
          style: TextStyle(
            color: ColorConstant.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Kebijakan Privasi Aplikasi GoDentist',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer gravida est sagittis, varius risus vel, rhoncus leo. Quisque dictum commodo metus sed molestie. Phasellus vulputate euismod dolor, laoreet aliquet ligula. Morbi non lacinia est, sit amet accumsan orci. Aliquam posuere eu neque vitae porta. Cras porta ante ut facilisis hendrerit. Aliquam maximus, ex et interdum bibendum, libero elit vestibulum lorem, id lacinia dui lorem eget nisl.\nQuisque sed quam quis risus sollicitudin gravida. Suspendisse condimentum vel dui a pellentesque. Cras consequat imperdiet urna quis elementum. Sed justo quam, auctor eget nibh lacinia, viverra finibus massa. Cras a enim ante. In in dapibus justo. Fusce vel massa massa. Nullam posuere justo vitae ligula euismod pretium. Nam ut scelerisque est. Ut interdum eros ex, vitae imperdiet sapien luctus ac. In hac habitasse platea dictumst.\nCurabitur sagittis consequat justo et malesuada. Praesent nec placerat nisl. Cras quis interdum nulla. Suspendisse lacinia tortor id congue cursus. Morbi finibus tincidunt felis ac sagittis. Aenean lobortis sem auctor eleifend tincidunt. Integer ornare rutrum tellus. Duis iaculis velit id felis fermentum suscipit. Fusce commodo condimentum odio nec lobortis. Sed eleifend quam purus, non sollicitudin nunc semper vel. In commodo placerat tincidunt. Suspendisse interdum, ipsum sed fringilla dictum, enim sapien laoreet odio, at gravida lacus odio finibus nulla. Pellentesque consequat purus hendrerit felis faucibus viverra. Nunc quam libero, pretium nec nisi pellentesque, venenatis tempor sapien.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

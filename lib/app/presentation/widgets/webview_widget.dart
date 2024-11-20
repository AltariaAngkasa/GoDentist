import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidgets extends StatefulWidget {
  final String title;
  final String url;
  const WebViewWidgets({super.key, required this.url, required this.title});

  @override
  State<WebViewWidgets> createState() => _WebViewWidgetsState();
}

class _WebViewWidgetsState extends State<WebViewWidgets> {
  late final WebViewController webVController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    webVController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) {
          setState(() {
            isLoading = true;
          });
        },
        onProgress: (progress) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (_) {
          setState(() {
            isLoading = false;
          });
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: ColorConstant.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'SatoshiBold',
            fontWeight: FontWeight.w700,
          ),
          // style: boldBlackFontStyle,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webVController),
          if (isLoading)
            Center(
                child: CircularProgressIndicator(
              color: ColorConstant.primaryColor,
            )),
        ],
      ),
    );
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class CCommon extends GetxController {
  final RxBool _isFetching = false.obs;
  bool get isFetching => _isFetching.value;
  set isFetching(bool newValue) {
    _isFetching.value = newValue;
  }

  final RxBool _isSuccessfull = false.obs;
  bool get isSuccessfull => _isSuccessfull.value;
  set isSuccessfull(bool newValue) {
    _isSuccessfull.value = newValue;
  }

  final RxString _message = "".obs;
  String get message => _message.value;
  set message(String newValue) {
    _message.value = newValue;
  }

  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}

import 'dart:io';

import 'package:GoDentist/app/data/models/detection/detection_teet_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class CDetection extends CCommon {
  final apiService = ApiService();

  XFile? selectedImage1;
  XFile? selectedImage2;
  XFile? selectedImage3;

  final Rx<DetectionTeethResponse> _detectionResponse =
      DetectionTeethResponse().obs;
  DetectionTeethResponse get detectionResponse => _detectionResponse.value;
  set detectionResponse(DetectionTeethResponse newValue) {
    _detectionResponse.value = newValue;
  }

  Future detectionTeeth() async {
    isFetching = true;
    final result = await apiService.detectionTeeth(
      File(selectedImage1!.path),
      File(selectedImage2!.path),
      File(selectedImage3!.path),
    );
    result.when(
      success: (data) {
        detectionResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = detectionResponse.message ?? "Successfull get detection";
        print(detectionResponse.toJson());
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }
}

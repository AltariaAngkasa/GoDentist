import 'dart:io';
import 'package:GoDentist/app/presentation/controllers/c_detection.dart';
import 'package:GoDentist/app/presentation/screen/detection/first_camera_screen.dart';
import 'package:GoDentist/app/presentation/screen/detection/result_detection_screen.dart';
import 'package:GoDentist/app/presentation/screen/detection/second_camera_screen%20copy.dart';
import 'package:GoDentist/app/presentation/screen/detection/third_camera_screen.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  final cDetection = Get.put(CDetection());
  Future<CameraDescription> _getInitialCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Pengambilan Foto Gigi',
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
          )),
      body: Obx(
        () => cDetection.isFetching
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/scan_loading_animation.json',
                      height: 100
                    ),
                    SizedBox(height: 16,),
                    Text(
                      "Tunggu Hasil Deteksi",
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      "Setelah mengambil gambar dan upload.\ntunggu sebentar kami memproses\ndan memberikan hasilnya.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 40),
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Ambil Foto Gigi Gigi Depan',
                    // textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final CameraDescription initialCamera =
                          await _getInitialCamera();
                      final result = await Get.to(
                          FirstCameraScreen(initialCamera: initialCamera));
                      if (result != null) {
                        setState(() {
                          if (result is XFile) {
                            cDetection.selectedImage1 = result;
                          } else if (result is String) {
                            // Do something if needed
                          }
                        });
                      }
                    },
                    child: cDetection.selectedImage1 == null
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                Text(
                                  'Tekan untuk ambil foto',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Image.file(
                              File(cDetection.selectedImage1!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ambil Foto Gigi Rahang Atas',
                    // textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final CameraDescription initialCamera =
                          await _getInitialCamera();
                      final result = await Get.to(SecondCameraScreen(
                        initialCamera: initialCamera,
                      ));
                      if (result != null) {
                        setState(() {
                          if (result is XFile) {
                            cDetection.selectedImage2 = result;
                          } else if (result is String) {
                            "";
                          }
                        });
                      }
                    },
                    child: cDetection.selectedImage2 == null
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                Text(
                                  'Tekan untuk ambil foto',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Image.file(
                              File(cDetection.selectedImage2!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ambil Foto Gigi Rahang Bawah',
                    // textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorConstant.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final CameraDescription initialCamera =
                          await _getInitialCamera();
                      final result = await Get.to(ThirdCameraScreen(
                        initialCamera: initialCamera,
                      ));
                      if (result != null) {
                        setState(() {
                          if (result is XFile) {
                            cDetection.selectedImage3 = result;
                          } else if (result is String) {
                            "";
                          }
                        });
                      }
                    },
                    child: cDetection.selectedImage3 == null
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                Text(
                                  'Tekan untuk ambil foto',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Image.file(
                              File(cDetection.selectedImage3!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(height: 40),
                  Button(
                    onPressed: () async {
                      await cDetection.detectionTeeth();
                      if (cDetection.isSuccessfull) {
                        if (cDetection.detectionResponse.data?.frontTeeth?.diseaseName == 'Bukan Gigi' ||
                            cDetection.detectionResponse.data?.frontTeeth?.cause == 'Silakan mengunggah foto gigi anda' ||
                            cDetection.detectionResponse.data?.frontTeeth?.treatment == 'Silakan mengunggah foto gigi anda')
                        {
                          Get.snackbar(
                            'Gagal',
                            'Tolong upload gigi anda!',
                            backgroundColor: Colors.red,
                            colorText: Colors.black,
                          );
                        } else {
                          Get.to(ResultDetection(data: cDetection.detectionResponse.data!));
                          Get.snackbar(
                            'Success',
                            'Berhasil mendeteksi gigi',
                            backgroundColor: Colors.green,
                            colorText: Colors.black,
                          );
                        }
                      } else {
                        Get.snackbar(
                          'Failed',
                          'Gagal mendeteksi gigi. ${cDetection.message}'.trim(),
                          backgroundColor: Colors.red,
                          colorText: Colors.black,
                        );
                      }
                    },
                    color: ColorConstant.primaryColor,
                    text: 'Upload',
                    size: 14,
                  ),
                ],
              ),
      ),
    );
  }
}

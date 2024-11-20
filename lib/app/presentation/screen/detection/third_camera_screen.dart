import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdCameraScreen extends StatefulWidget {
  final CameraDescription initialCamera;
  const ThirdCameraScreen({Key? key, required this.initialCamera})
      : super(key: key);

  @override
  _ThirdCameraScreenState createState() => _ThirdCameraScreenState();
}

class _ThirdCameraScreenState extends State<ThirdCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late bool _isFrontCamera;
  late FlashMode _flashMode;

  @override
  void initState() {
    super.initState();
    _isFrontCamera =
        widget.initialCamera.lensDirection == CameraLensDirection.front;
    _flashMode = FlashMode.off;
    _controller = CameraController(
      widget.initialCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCamera() async {
    final CameraDescription newCameraDescription = _isFrontCamera
        ? await _getCamera(CameraLensDirection.back)
        : await _getCamera(CameraLensDirection.front);

    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _controller = CameraController(
        newCameraDescription,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  Future<CameraDescription> _getCamera(CameraLensDirection direction) async {
    final cameras = await availableCameras();
    return cameras.firstWhere((camera) => camera.lensDirection == direction);
  }

  void _toggleFlash() async {
    try {
      // Mencoba mengatur mode flash, jika kamera tidak mendukung flash akan menghasilkan error
      await _controller.setFlashMode(
          _flashMode == FlashMode.off ? FlashMode.always : FlashMode.off);
      // Jika berhasil, update state untuk merubah UI
      setState(() {
        _flashMode =
            _flashMode == FlashMode.off ? FlashMode.always : FlashMode.off;
      });
    } catch (e) {
      debugPrint('Error setting flash mode: $e');
      // Anda bisa memberikan feedback ke pengguna bahwa flash tidak didukung
    }
  }

  Future<XFile?> capturePhoto() async {
    try {
      await _controller.setFlashMode(_flashMode);
      XFile file = await _controller.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  void _onTakePhotoPressed() async {
    final xFile = await capturePhoto();
    if (xFile != null) {
      Navigator.pop(context, xFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.44,
                    width: double.infinity,
                    child: CameraPreview(_controller,
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 24.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Gigi Rahang Bawah",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _toggleFlash();
                                      },
                                      icon: Icon(
                                        Icons.flash_off_sharp,
                                        size: 24.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      _toggleCamera();
                                    },
                                    icon: Icon(
                                      Icons.cameraswitch_outlined,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 180,
                            ),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(20),
                              dashPattern: const [10, 10],
                              color: Colors.white,
                              strokeWidth: 2,
                              child: SizedBox(
                                width: 150,
                                height: 110,
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Colors.red),
                    child: Text(
                      "Buka lebar mulut anda, posisikan kamera anda diatas dan ambil foto bagian rahang gigi bawah anda sesuai dengan pola",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _onTakePhotoPressed,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(70, 70),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

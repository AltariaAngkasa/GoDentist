import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseImageSourceDialog extends StatelessWidget {

  final Function(ImageSourceEnum) onSelected;

  const ChooseImageSourceDialog({required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 2,
              width: 80,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                onSelected(ImageSourceEnum.GALLERY);
              },
              child: ListTile(
                title: Text("Gallery"),
                leading: Icon(Icons.photo),
              ),
            ),
            GestureDetector(
              onTap: () {
                onSelected(ImageSourceEnum.CAMERA);
              },
              child: ListTile(
                title: Text("Kamera"),
                leading: Icon(Icons.camera_alt),
              ),
            )
          ],
        ),
      ),
    );
  }

}

enum ImageSourceEnum {
  GALLERY,
  CAMERA
}

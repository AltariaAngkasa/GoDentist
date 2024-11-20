import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputVoucherCodeDialog extends StatefulWidget {

  final Function(String) onSubmit;

  const InputVoucherCodeDialog({required this.onSubmit, super.key});

  @override
  State<InputVoucherCodeDialog> createState() => _InputVoucherCodeDialogState();
}

class _InputVoucherCodeDialogState extends State<InputVoucherCodeDialog> {

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(child: Text("Punya Kode Promo ? ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Masukkan kode promonya disini", style: TextStyle(fontSize: 14, color: Colors.black87),),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "contoh : 8210YH",
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    widget.onSubmit(textEditingController.text.toString());
                  },
                  child: Text("Lanjutkan"),
                ),
              ),
              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}

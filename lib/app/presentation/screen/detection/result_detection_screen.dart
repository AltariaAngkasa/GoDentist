import 'package:GoDentist/app/data/models/detection/detection_teet_response.dart';
import 'package:GoDentist/app/presentation/screen/doctor/doctor_screen.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultDetection extends StatefulWidget {
  final Data data;
  const ResultDetection({
    required this.data,
    super.key,
  });

  @override
  State<ResultDetection> createState() => _ResultDetectionState();
}

class _ResultDetectionState extends State<ResultDetection> {

  List<String?> diseaseCause = [];
  List<String?> diseaseTreatment = [];

  @override
  void initState() {
    diseaseCause.addAll([
      widget.data.frontTeeth?.cause,
      widget.data.upperTeeth?.cause,
      widget.data.lowerTeeth?.cause,
    ]);
    diseaseTreatment.addAll([
      widget.data.frontTeeth?.treatment,
      widget.data.upperTeeth?.treatment,
      widget.data.lowerTeeth?.treatment,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Hasil Deteksi Kesehatan Gigi',
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
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 24),
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 131,
                          width: 90,
                          child: Image.network(widget.data.frontTeeth?.imageUrl ?? "", fit: BoxFit.cover,),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 131,
                          width: 90,
                          child: Image.network(widget.data.upperTeeth?.imageUrl ?? "", fit: BoxFit.cover,),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 131,
                          width: 90,
                          child: Image.network(widget.data.lowerTeeth?.imageUrl ?? "", fit: BoxFit.cover,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Kondisi Gigi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: (widget.data.diseaseStatus == "Gigi Tidak Sehat")
                                  ? AssetImage(
                                'assets/images/gigi1.png',
                              )
                                  : AssetImage(
                                'assets/images/gigi1.png',
                              ),
                            ),
                            SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hari Ini",
                                ),
                                SizedBox(height: 8),
                                Text(
                                  // "Gigi Tidak Sehat",
                                  widget.data.diseaseStatus ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Diagnosa Penyakit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("1. ${widget.data.frontTeeth?.diseaseName ?? ""}"),
                            Text("2. ${widget.data.upperTeeth?.diseaseName ?? ""}"),
                            Text("3. ${widget.data.lowerTeeth?.diseaseName ?? ""}"),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Penyebab Penyakit",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                            ),
                            SizedBox(height: 8),
                            ...diseaseCause.indexed.map((e) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${(e.$1 + 1).toString()}. ", textAlign: TextAlign.justify,),
                                      Expanded(
                                        child: Text(e.$2.toString(), textAlign: TextAlign.justify,),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                ],
                              );
                            }),
                            SizedBox(height: 8),
                            Text(
                              "Rekomendasi Perawatan",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                            ),
                            SizedBox(height: 8),
                            ...diseaseTreatment.indexed.map((e) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${(e.$1 + 1).toString()}. ", textAlign: TextAlign.justify,),
                                      Expanded(
                                        child: Text(e.$2.toString(), textAlign: TextAlign.justify,),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Button(
              onPressed: () {
                Get.to(DoctorScreen());
              },
              color: ColorConstant.redColor,
              text: 'Lakukan Perawatan',
              size: 14,
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

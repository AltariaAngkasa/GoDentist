import 'package:GoDentist/app/data/models/clinic/detail_clinic_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_clinic.dart';
import 'package:GoDentist/app/presentation/controllers/c_payment.dart';
import 'package:GoDentist/app/presentation/screen/main/main_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultBookingDoctorScreen extends StatefulWidget {
  final Doctor doctor;
  final Clinic clinicData;
  final bool isCOD;

  const ResultBookingDoctorScreen({required this.doctor, required this.clinicData, this.isCOD = false, super.key});

  @override
  State<ResultBookingDoctorScreen> createState() => _ResultBookingDoctorScreenState();
}

class _ResultBookingDoctorScreenState extends State<ResultBookingDoctorScreen> {

  final cClinic = Get.put(CClinic());
  final cPayment = Get.put(CPayment());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiket Booking Klinik", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 16, top: 16),
        children: [
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.doctor.photo ?? ""),
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor.name ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.doctor.specialization ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.clinicData.name ?? '-',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${widget.clinicData.address ?? "-"}, ${widget.clinicData.subDistrict ?? ""}, ${widget.clinicData.city ?? ""}, ${widget.clinicData.province ?? ""}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.clinicData.photoUrl ?? ""),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Pendaftaran Tanggal: ${
                                widget.isCOD
                                    ? cPayment.paymentBookingResponse.data?.date
                                    : cPayment.checkPaymentBookingDoctorResponse.data?.date ?? ""
                              }",
                              style: TextStyle(fontSize: 10, color: ColorConstant.blackColor,),
                            ),
                          SizedBox(height: 16),
                          Text(
                            "Tujuan: ${
                              widget.isCOD
                                  ? cPayment.paymentBookingResponse.data?.servicesName?.join(", ")
                                  : cPayment.checkPaymentBookingDoctorResponse.data?.servicesName
                            }",
                            style: TextStyle(fontSize: 10,),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(width: 24),
                    Column(
                      children: [
                        Text(
                          widget.isCOD
                              ? "${cPayment.paymentBookingResponse.data?.totalBooking}"
                              : cPayment.checkPaymentBookingDoctorResponse.data?.totalBooking.toString() ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          "Total Antrian",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Nomor Antrian Klinik",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12,),
                        Text(
                          widget.isCOD
                              ? cPayment.paymentBookingResponse.data?.queueQuota.toString() ?? ""
                              : cPayment.checkPaymentBookingDoctorResponse.data?.queueQuota.toString() ?? "",
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.grey,),
                        ),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      children: [
                        Text(
                          "Nomor Antrian Anda",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,),
                        ),
                        SizedBox(height: 12,),
                        Text(
                          widget.isCOD
                              ? cPayment.paymentBookingResponse.data?.yourQueue.toString() ?? ""
                              : cPayment.checkPaymentBookingDoctorResponse.data?.yourQueue.toString() ?? "",
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: ColorConstant.primaryColor,),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Penting",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.blackColor,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "1. Pastikan anda datang tepat waktu, jika anda melewatkan nomor antrian anda maka harus mengambil kembali nomor antrian anda",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorConstant.blackColor,
                  ),
                ),
                Text(
                  "2. Tidak diperbolehkan membawa benda yang dapat mengancam nyawa seseorang seperti benda tajam, mudah meledak, dan lain lain",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorConstant.blackColor,
                  ),
                ),
                Text(
                  "3. Tetap menjaga kebersihan klinik dan dilarang membuang sampah sembarangan",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorConstant.blackColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
                )
              ),
              onPressed: () {
                Get.offAll(() => MainScreen());
              },
              child: Text("Kembali ke Beranda"),
            ),
          )
        ],
      ),
    );
  }
}

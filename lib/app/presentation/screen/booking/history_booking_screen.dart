import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:GoDentist/app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/models/history/history_booking_clinic_response.dart';

class HistoryBookingScreen extends StatelessWidget {

  final HistoryBookingClinicResponseData data;

  const HistoryBookingScreen({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Booking"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Column(
                      children: [
                        Text('Nomor Antrian Kamu', style: TextStyle(fontSize: 16, color: Colors.white),),
                        Text("9", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset("assets/images/doctor.jpeg", height: 80, width: 80, fit: BoxFit.cover,),
                  ),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.serviceDetails?.doctorName ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      SizedBox(height: 4,),
                      Text(data.serviceDetails?.doctorSpecialization ?? '', style: TextStyle(fontSize: 14, color: Colors.grey),),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.serviceDetails?.clinicName ?? "", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 4,),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      Text("Lihat Maps", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                      SizedBox(width: 2,),
                      Icon(Icons.arrow_forward_ios_outlined, size: 16, color: Colors.blue,)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/ic-time-oclock.svg', width: 28, height: 28,),
                      SizedBox(width: 6,),
                      Text("Jadwal Konsultasi Online", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(formatDate(data.serviceDetails?.date.toString()), style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600),),
                  )
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/ic-tooth.svg', width: 28, height: 28,),
                      SizedBox(width: 6,),
                      Text("Jenis Pemeriksaan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(data.serviceDetails?.servicesName?.firstOrNull ?? "", style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),),
                  )
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/ic-information-circle.svg', width: 28, height: 28,),
                      SizedBox(width: 6,),
                      Text("Informasi Penting", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  itemInformation(number: 1, text: "Pastikan anda datang tepat waktu, jika anda melewatkan nomor antrian anda maka harus mengambil kembali nomor antrian anda"),
                  itemInformation(number: 2, text: "Tidak diperbolehkan membawa benda yang dapat mengancam nyawa seseorang seperti benda tajam, mudah meledak, dan lain lain"),
                  itemInformation(number: 3, text: "Tetap menjaga kebersihan klinik dan dilarang membuang sampah sembarangan"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget itemInformation({required int number, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number. "),
          SizedBox(width: 6,),
          Expanded(child: Text(text))
        ],
      ),
    );
  }

}

import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';
import 'package:GoDentist/app/data/models/doctor/search_doctor_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_doctor.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/screen/doctor/chat_consultation_screen.dart';
import 'package:GoDentist/app/presentation/screen/doctor/payment_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cDoctor = Get.put(CDoctor());

    Widget buildDoctorCard(DataSearchDoctor doctor) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    doctor.photo ?? "https://via.placeholder.com/150",
                  ),
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name!,
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      doctor.specialization!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      doctor.workPlace!,
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biaya',
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Rp. ${doctor.consultationPrice!}',
                      style: TextStyle(
                        color: ColorConstant.redColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(PaymentScreen(doctor: DoctorResponseData.fromSearch(doctor)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstant.primaryColor,
                    ),
                    child: Text(
                      'Konsultasi',
                      style: TextStyle(
                        color: ColorConstant.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Konsultasi Dokter Gigi',
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
      body: RefreshIndicator(
        onRefresh: () async {
          cDoctor.getDoctor();
        },
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: cDoctor.searchQuery,
                decoration: InputDecoration(
                  hintText: 'Cari Dokter Gigi',
                  hintStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstant.primaryColor,
                  ),
                  contentPadding: EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  cDoctor.searchDoctor(value);
                },
              ),
            ),
            SizedBox(height: 8),
            Obx(() => cDoctor.isFetching
              ? Expanded(
                  child: ListView.builder(
                  itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(width: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 100,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 100,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ))
              : Builder(
                  builder: (context) {
                    if (cDoctor.searchQuery.text.isEmpty) {
                      return Expanded(
                        child: cDoctor.searchDoctorResponse.data != null &&
                            cDoctor.searchDoctorResponse.data!.isNotEmpty
                            ? ListView.builder(
                          itemCount: cDoctor.searchDoctorResponse.data!.length,
                          itemBuilder: (context, index) {
                            return buildDoctorCard(cDoctor.searchDoctorResponse.data![index]);
                          },
                        )
                            : ListView.builder(
                          itemCount: cDoctor.doctorResponse.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: EdgeInsets.all(12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(
                                          cDoctor.doctorResponse.data?[index].photo
                                              ?? "https://via.placeholder.com/150",
                                        ),
                                      ),
                                      SizedBox(width: 24),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cDoctor.doctorResponse.data![index].name!,
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            cDoctor.doctorResponse.data![index]
                                                .specialization!,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            cDoctor.doctorResponse.data![index]
                                                .workPlace!,
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                          if(cDoctor.doctorResponse.data![index].doctorWorkSchedule?.isNotEmpty == true)
                                            Text(
                                              '${cDoctor.doctorResponse.data![index].doctorWorkSchedule![0].fromHour!} - ${cDoctor.doctorResponse.data![index].doctorWorkSchedule![0].untilHour}',
                                              style: TextStyle(
                                                color: ColorConstant.redColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Biaya',
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            'Rp. ${cDoctor.doctorResponse.data![index].consultationPrice!}',
                                            style: TextStyle(
                                              color: ColorConstant.redColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(PaymentScreen(doctor: cDoctor.doctorResponse.data![index]));
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: ColorConstant.primaryColor,
                                            ),
                                            child: Text(
                                              'Konsultasi',
                                              style: TextStyle(
                                                color: ColorConstant.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Get.to(() => ChatConsultationScreen(
                                      //         doctor: cDoctor.doctorResponse
                                      //             .data![index]));
                                      //   },
                                      //   child: Container(
                                      //       padding: EdgeInsets.symmetric(
                                      //           horizontal: 14, vertical: 10),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(8),
                                      //         color: ColorConstant.primaryColor,
                                      //       ),
                                      //       child: Text(
                                      //         'Chat',
                                      //         style: TextStyle(
                                      //           color: ColorConstant.whiteColor,
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.bold,
                                      //         ),
                                      //       )),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    final data = cDoctor.searchDoctorResponse.data;
                    return Expanded(
                      child: data != null && data.isEmpty == true
                          ? Center(
                        child: Text('Pencarian tidak ditemukan'),
                      )
                          : ListView.builder(
                        itemCount: cDoctor.searchDoctorResponse.data!.length,
                        itemBuilder: (context, index) {
                          return buildDoctorCard(
                              cDoctor.searchDoctorResponse.data![index]);
                        },
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}

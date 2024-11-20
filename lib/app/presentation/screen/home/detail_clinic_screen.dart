import 'package:GoDentist/app/data/models/clinic/detail_clinic_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_clinic.dart';
import 'package:GoDentist/app/presentation/screen/booking/booking_doctor_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailClinicScreen extends StatefulWidget {
  final int id;
  const DetailClinicScreen({required this.id, super.key});

  @override
  State<DetailClinicScreen> createState() => _DetailClinicScreenState();
}

class _DetailClinicScreenState extends State<DetailClinicScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  final cClinic = Get.put(CClinic());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cClinic.isFetching
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Detail Klinik',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Image.network(
                      cClinic.detailClinicResponse.data!.clinic!.photoUrl ?? "https://via.placeholder.com/150",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(
                      () => Text(
                        cClinic.detailClinicResponse.data!.clinic!.name ?? "",
                        style: TextStyle(
                          color: ColorConstant.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Dokter'), // Tab untuk dokter
                      Tab(text: 'Detail'), // Tab untuk informasi
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Obx(() {
                          final doctorList = cClinic.detailClinicResponse.data?.doctor ?? [];
                          return doctorList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: doctorList.length,
                                  itemBuilder: (context, index) {
                                    final doctor = doctorList[index];
                                    DoctorWorkSchedule? doctorSchedule;
                                    if(doctor.doctorWorkSchedule != null && doctor.doctorWorkSchedule?.isNotEmpty == true) {
                                      doctorSchedule = doctor.doctorWorkSchedule?[0];
                                    }
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                      padding: EdgeInsets.all(12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    doctor.name ?? "",
                                                    style: TextStyle(
                                                      color: ColorConstant.blackColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    doctor.specialization ?? "",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    doctor.workPlace ?? "",
                                                    style: TextStyle(
                                                      color: ColorConstant.blackColor,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  if(doctorSchedule != null)
                                                    Text(
                                                      '${doctorSchedule.fromDay ?? ""} - ${doctorSchedule.untilDay ?? ""}',
                                                      style: TextStyle(
                                                        color: ColorConstant.blackColor,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  if(doctorSchedule != null)
                                                    Text(
                                                      '${doctorSchedule.fromHour ?? ""} - ${doctorSchedule.untilHour ?? ""}',
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
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if(doctorSchedule != null) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => BookingDoctorScreen(
                                                          doctor: doctor,
                                                          doctorWorkSchedule: doctorSchedule!,
                                                          clinic: cClinic.detailClinicResponse.data!.clinic!,
                                                          idClinic: widget.id,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    Get.snackbar(
                                                      'Gagal',
                                                      'Tidak bisa melakukan booking saat ini',
                                                      backgroundColor: Colors.red[200],
                                                      margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: ColorConstant.primaryColor,
                                                  ),
                                                  child: Text(
                                                    'Booking',
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
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'Tidak ada dokter yang tersedia',
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                        }),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    cClinic.detailClinicResponse.data!.clinic!
                                            .name ??
                                        "",
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              SizedBox(height: 6),
                              Obx(() => Text(
                                    cClinic.detailClinicResponse.data!.clinic!
                                            .address ??
                                        "",
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 14,
                                    ),
                                  )),
                              SizedBox(height: 6),
                              Obx(() => Text(
                                    "${cClinic.detailClinicResponse.data!.clinic!.open} - ${cClinic.detailClinicResponse.data!.clinic!.closed}",
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 14,
                                    ),
                                  )),
                              SizedBox(height: 6),
                              Obx(() => Text(
                                    cClinic.detailClinicResponse.data!.clinic!
                                            .phoneNumber ??
                                        "",
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 14,
                                    ),
                                  )),
                              SizedBox(height: 6),
                              Obx(
                                () => Text(
                                  cClinic.detailClinicResponse.data!.clinic!
                                          .websiteUrl ??
                                      "",
                                  style: TextStyle(
                                    color: ColorConstant.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

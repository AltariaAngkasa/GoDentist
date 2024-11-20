import 'package:GoDentist/app/presentation/screen/doctor/history_consultation_screen.dart';
import 'package:GoDentist/app/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/color_constant.dart';
import '../../../utils/tools.dart';
import '../../controllers/c_history.dart';

class ListConsultationHistoryScreen extends StatefulWidget {
  const ListConsultationHistoryScreen({super.key});

  @override
  State<ListConsultationHistoryScreen> createState() => _ListConsultationHistoryScreenState();
}

class _ListConsultationHistoryScreenState extends State<ListConsultationHistoryScreen> {

  final cHistory = Get.put(CHistory());

  @override
  Widget build(BuildContext context) {
    return Obx(() => cHistory.isFetchingConsultation.value
      ? Center(child: CircularProgressIndicator.adaptive())
      : content(context));
  }

  Widget content(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await cHistory.getHistoryConsultation();
      },
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 50),
        itemCount: cHistory.historyConsultationResponse.data?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final data = cHistory.historyConsultationResponse.data?[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cHistory.historyConsultationResponse.data?[index].midtransResponse?.transactionTime != null
                          ? formatDate(cHistory
                          .historyConsultationResponse
                          .data?[index]
                          .midtransResponse
                          ?.transactionTime
                          .toString() ??
                          "")
                          : "",
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cHistory.historyConsultationResponse.data?[index].midtransResponse?.transactionTime != null
                          ? formatTime(cHistory.historyConsultationResponse.data?[index].midtransResponse
                          ?.transactionTime.toString() ?? "")
                          : "",
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: data?.serviceDetails?.photo != null
                              ? Image.network(data!.serviceDetails!.photo!, width: 80, height: 80, fit: BoxFit.cover,)
                              : Image.asset('assets/images/doctor.jpeg', width: 80, height: 80, fit: BoxFit.cover,),
                        ),
                        SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data?.serviceDetails?.name ?? "",
                              style: TextStyle(
                                color: ColorConstant.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data?.typeService?.toFirstUpperCase() ?? "-",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 6,),

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
                              'Status',
                              style: TextStyle(
                                color: ColorConstant.blackColor,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              data?.transactionStatus?.toString().toFirstUpperCase() ?? "",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(HistoryConsultationScreen(data: data!));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: ColorConstant.redColor,
                                ),
                              ),
                              child: Text(
                                'Lihat Hasil Konsultasi',
                                style: TextStyle(
                                  color: ColorConstant.redColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
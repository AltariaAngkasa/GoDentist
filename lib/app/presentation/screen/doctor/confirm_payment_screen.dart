import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_payment.dart';
import 'package:GoDentist/app/presentation/screen/doctor/chat_consultation_screen.dart';
import 'package:GoDentist/app/presentation/screen/main/main_screen.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/presentation/widgets/payment_countdown_timer.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/tools.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final DoctorResponseData doctor;
  const ConfirmPaymentScreen({
    required this.doctor,
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {

  final cPayment = Get.put(CPayment());
  bool isTimesUp = false;
  String paymentBank = '';

  Future<bool> _onBackPressed(BuildContext context) async {
    if (!isTimesUp) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah kamu ingin mengakhiri pembayaran?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Get.offAll(MainScreen());
                Get.back();
              },
            ),
          ],
        ),
      );
      return result ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String paymentMethod = '';
    bool isEChannel = cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'echannel';

    if (isEChannel) {
      paymentMethod = 'Mandiri Bill Key';
      paymentBank = 'mandiri';
    }
    else {
      if (cPayment.paymentConsultationResponse.data?.midtransResponse?.vaNumbers != null &&
          cPayment.paymentConsultationResponse.data!.midtransResponse!.vaNumbers!.isNotEmpty &&
          cPayment.paymentConsultationResponse.data?.midtransResponse?.vaNumbers![0].bank != null) {
        String bank = cPayment.paymentConsultationResponse.data!.midtransResponse!.vaNumbers![0].bank!;
        switch (bank) {
          case 'bni':
            paymentMethod = 'BNI Virtual Account';
            paymentBank = 'bni';
            break;
          case 'bri':
            paymentMethod = 'BRI Virtual Account';
            paymentBank = 'bri';
            break;
          case 'bca':
            paymentMethod = 'BCA Virtual Account';
            paymentBank = 'bca';
            break;
          default:
            paymentMethod = '';
        }
      } else {
        paymentMethod = '';
      }
    }

    return Obx(
      () => cPayment.isFetching
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : WillPopScope(
              onWillPop: () {
                if (cPayment.checkPaymentConsultationResponse.data?.midtransResponse?.statusCode == "200") {
                  Get.offAllNamed(Routes.main);
                }
                return _onBackPressed(context);
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Detail Pembayaran',
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
                      cPayment.checkPaymentConsultationResponse.data?.midtransResponse?.statusCode == "200"
                          ? Get.offAllNamed(Routes.main)
                          : _onBackPressed(context);
                    },
                  ),
                ),
                body: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(height: 10,),
                        PaymentCountDownTimer(
                          expiryDate: cPayment.paymentConsultationResponse.data?.midtransResponse?.expiryTime ??  DateTime.now().add(Duration(minutes: 10)),
                          onTimesUp: () {
                            setState(() {
                              isTimesUp = true;
                            });
                          },
                        ),
                        SizedBox(height: 16,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.payments_sharp,
                                color: ColorConstant.primaryColor,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Lakukan Transfer ke',
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'echannel'
                                            ? 'assets/images/mandiri.png'
                                            : (cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'bank_transfer' &&
                                                    cPayment
                                                            .paymentConsultationResponse
                                                            .data
                                                            ?.midtransResponse
                                                            ?.vaNumbers != null &&
                                                    cPayment
                                                        .paymentConsultationResponse
                                                        .data!
                                                        .midtransResponse!
                                                        .vaNumbers!
                                                        .isNotEmpty &&
                                                    cPayment
                                                            .paymentConsultationResponse
                                                            .data
                                                            ?.midtransResponse
                                                            ?.vaNumbers![0]
                                                            .bank !=
                                                        null &&
                                                    cPayment
                                                            .paymentConsultationResponse
                                                            .data
                                                            ?.midtransResponse
                                                            ?.vaNumbers![0]
                                                            .bank ==
                                                        'bni')
                                                ? 'assets/images/bni.png'
                                                : (cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'bank_transfer' &&
                                                        cPayment
                                                                .paymentConsultationResponse
                                                                .data
                                                                ?.midtransResponse
                                                                ?.vaNumbers !=
                                                            null &&
                                                        cPayment
                                                            .paymentConsultationResponse
                                                            .data!
                                                            .midtransResponse!
                                                            .vaNumbers!
                                                            .isNotEmpty &&
                                                        cPayment.paymentConsultationResponse.data?.midtransResponse?.vaNumbers![0].bank != null &&
                                                        cPayment.paymentConsultationResponse.data?.midtransResponse?.vaNumbers![0].bank == 'bri')
                                                    ? 'assets/images/bri.png'
                                                    : 'assets/images/bca.png',
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        paymentMethod,
                                        style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    cPayment
                                                .paymentConsultationResponse
                                                .data
                                                ?.midtransResponse
                                                ?.paymentType ==
                                            "bank_transfer"
                                        ? cPayment
                                                .paymentConsultationResponse
                                                .data
                                                ?.midtransResponse
                                                ?.vaNumbers![0]
                                                .vaNumber ??
                                            ""
                                        : cPayment
                                                .paymentConsultationResponse
                                                .data
                                                ?.midtransResponse
                                                ?.billKey ??
                                            "",
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: ColorConstant.primaryColor,
                                ),
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text: cPayment
                                                  .paymentConsultationResponse
                                                  .data
                                                  ?.midtransResponse
                                                  ?.paymentType ==
                                              "bank_transfer"
                                          ? cPayment
                                                  .paymentConsultationResponse
                                                  .data
                                                  ?.midtransResponse
                                                  ?.vaNumbers![0]
                                                  .vaNumber ??
                                              ""
                                          : cPayment
                                                  .paymentConsultationResponse
                                                  .data
                                                  ?.midtransResponse
                                                  ?.billKey ??
                                              "",
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'bank_transfer'
                            ? SizedBox()
                            : SizedBox(height: 12),
                        cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'bank_transfer'
                            ? SizedBox()
                            : Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/mandiri.png',
                                              width: 30,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              'Mandiri Biller Code',
                                              style: TextStyle(
                                                color: ColorConstant.blackColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          cPayment
                                                  .paymentConsultationResponse
                                                  .data
                                                  ?.midtransResponse
                                                  ?.billerCode ??
                                              "",
                                          style: TextStyle(
                                            color: ColorConstant.blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.copy,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      onPressed: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: cPayment
                                                    .paymentConsultationResponse
                                                    .data
                                                    ?.midtransResponse
                                                    ?.billerCode ??
                                                "",
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(height: 12,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Rp. ${cPayment.paymentConsultationResponse.data?.midtransResponse?.grossAmount ?? ""}",
                            style: TextStyle(
                              color: ColorConstant.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        Container(
                          height: 8,
                          width: double.infinity,
                          color: Colors.grey[50],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note,
                                color: ColorConstant.primaryColor,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Cara Pembayaran',
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 16, right: 16, bottom: 150),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType ==
                                        'echannel'
                                    ? 'Transfer Melalui Mandiri Mobile Banking'
                                    : (cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'bank_transfer' &&
                                            cPayment
                                                    .paymentConsultationResponse
                                                    .data
                                                    ?.midtransResponse
                                                    ?.vaNumbers !=
                                                null &&
                                            cPayment
                                                .paymentConsultationResponse
                                                .data!
                                                .midtransResponse!
                                                .vaNumbers!
                                                .isNotEmpty &&
                                            cPayment
                                                    .paymentConsultationResponse
                                                    .data
                                                    ?.midtransResponse
                                                    ?.vaNumbers![0]
                                                    .bank !=
                                                null &&
                                            cPayment
                                                    .paymentConsultationResponse
                                                    .data
                                                    ?.midtransResponse
                                                    ?.vaNumbers![0]
                                                    .bank ==
                                                'bni')
                                        ? 'Transfer Melalui BNI Mobile Banking'
                                        : (cPayment.paymentConsultationResponse.data?.midtransResponse?.paymentType == 'bank_transfer' &&
                                                cPayment
                                                        .paymentConsultationResponse
                                                        .data
                                                        ?.midtransResponse
                                                        ?.vaNumbers !=
                                                    null &&
                                                cPayment
                                                    .paymentConsultationResponse
                                                    .data!
                                                    .midtransResponse!
                                                    .vaNumbers!
                                                    .isNotEmpty &&
                                                cPayment.paymentConsultationResponse.data?.midtransResponse?.vaNumbers![0].bank != null &&
                                                cPayment.paymentConsultationResponse.data?.midtransResponse?.vaNumbers![0].bank == 'bri')
                                            ? 'Transfer Melalui BRI Mobile Banking'
                                            : 'Transfer Melalui BCA Mobile Banking',
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(getPaymentGuide(paymentBank)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Button(
                              onPressed: () async {
                                // Panggil method dari controller
                                await cPayment.getStatusPaymentConsultation(
                                  cPayment.paymentConsultationResponse.data
                                          ?.orderId ??
                                      "",
                                  cPayment.paymentConsultationResponse.data
                                          ?.midtransResponse?.transactionId ??
                                      "",
                                );
                                // Setelah method dipanggil, cek hasilnya
                                if (cPayment.isSuccessfull) {
                                  if (cPayment.checkPaymentConsultationResponse.data?.midtransResponse?.statusCode == '201') {
                                    Get.snackbar(
                                      "Perhatian",
                                      "Harap selesaikan pembayaran terlebih dahulu",
                                      backgroundColor: Colors.yellow,
                                      colorText: Colors.black,
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Success",
                                      cPayment.message,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                    modalBottomSheet(context);
                                  }
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    cPayment.message,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              },
                              color: ColorConstant.primaryColor,
                              text: 'Cek Pembayaran',
                              size: 14,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    color: ColorConstant.primaryColor),
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                maximumSize: Size(double.infinity, 50),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Ganti Metode Pembayaran',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<dynamic> modalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/images/ic_done.png'),
                SizedBox(height: 24),
                Text(
                  'Yeayy, Pembayaran Selesai',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 3),
                Text(
                  'Klik “Mulai Konsultasi” untuk segera konsultasi dengan\n${widget.doctor.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => ChatConsultationScreen(doctor: widget.doctor, paymentConsultationData: cPayment.paymentConsultationResponse.data!,));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      maximumSize: Size(double.infinity, 50),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Mulai Konsultasi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

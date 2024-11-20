import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/controllers/c_payment.dart';
import 'package:GoDentist/app/presentation/screen/doctor/confirm_payment_screen.dart';
import 'package:GoDentist/app/presentation/screen/doctor/widgets/input_voucher_code_dialog.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  final DoctorResponseData doctor;
  const PaymentScreen({required this.doctor, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedRadioValue;

  @override
  void initState() {
    super.initState();
    selectedRadioValue = "bni"; // Beri nilai awal pada initState
  }

  @override
  Widget build(BuildContext context) {
    final cPayment = Get.put(CPayment());
    final cHome = Get.put(CHome());

    int consultationPrice = int.parse(widget.doctor.consultationPrice ?? "");
    int platformFee = 1000;
    int totalPayment = consultationPrice + platformFee;

    return Obx(
      () => cPayment.isFetching
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
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
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            color: Color(0xff3A5FD9),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: '${widget.doctor.name} ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'Sedang Menunggu kamu untuk konsultasi',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Yuk lakukan pembayaran sekarang juga..',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
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
                                  'Detail Pembayaran',
                                  style: TextStyle(
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Biaya Konsultasi 30 Menit',
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Rp ${widget.doctor.consultationPrice}",
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      'Biaya Platform',
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Rp 1000',
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  color: Colors.grey[100],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      'Total Pembayaran',
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Rp. ${totalPayment.toString()}',
                                      style: TextStyle(
                                        color: Color(0xff3A5FD9),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 5,
                            width: double.infinity,
                            color: Colors.grey[100],
                          ),
                          SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                enableDrag: true,
                                isScrollControlled: true,
                                builder: (context) {
                                  return InputVoucherCodeDialog(
                                    onSubmit: (code) {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.discount_outlined,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Voucher Dokter',
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 5,
                            width: double.infinity,
                            color: Colors.grey[100],
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money_outlined,
                                  color: ColorConstant.primaryColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Metode Pembayaran',
                                  style: TextStyle(
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRadioValue =
                                          "bni"; // Atur nilai yang sesuai saat radio button diklik
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/bni.png',
                                        width: 30,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'BNI Virtual Account',
                                        style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Radio(
                                        value: "bni", // Memberikan nilai 0
                                        groupValue:
                                            selectedRadioValue, // Gunakan variabel selectedRadioValue
                                        onChanged: (value) {
                                          // Ubah nilai selectedRadioValue ketika radio button dipilih
                                          setState(() {
                                            selectedRadioValue = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRadioValue =
                                          "mandiri"; // Atur nilai yang sesuai saat radio button diklik
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/mandiri.png',
                                        width: 30,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Mandiri Virtual Account',
                                        style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Radio(
                                        value: "mandiri", // Memberikan nilai 0
                                        groupValue:
                                            selectedRadioValue, // Gunakan variabel selectedRadioValue
                                        onChanged: (value) {
                                          // Ubah nilai selectedRadioValue ketika radio button dipilih
                                          setState(() {
                                            selectedRadioValue = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRadioValue =
                                          "bri"; // Atur nilai yang sesuai saat radio button diklik
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/bri.png',
                                        width: 30,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'BRI Virtual Account',
                                        style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Radio(
                                        value: "bri", // Memberikan nilai 0
                                        groupValue: selectedRadioValue, // Gunakan variabel selectedRadioValue
                                        onChanged: (value) {
                                          // Ubah nilai selectedRadioValue ketika radio button dipilih
                                          setState(() {
                                            selectedRadioValue = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRadioValue = "bca"; // Atur nilai yang sesuai saat radio button diklik
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/bca.png', width: 30,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'BCA Virtual Account',
                                        style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Radio(
                                        value: "bca", // Memberikan nilai 0
                                        groupValue:
                                            selectedRadioValue, // Gunakan variabel selectedRadioValue
                                        onChanged: (value) {
                                          // Ubah nilai selectedRadioValue ketika radio button dipilih
                                          setState(() {
                                            selectedRadioValue = value;
                                            print(selectedRadioValue);
                                          });
                                        },
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
              bottomNavigationBar: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Biaya Konsultasi',
                            style: TextStyle(
                              color: ColorConstant.blackColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rp. ${totalPayment.toString()}",
                            style: TextStyle(
                              color: Color(0xff3A5FD9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 100),
                      Expanded(
                        child: Button(
                          color: Color(0xff3A5FD9),
                          size: 14,
                          text: 'Bayar Konsultasi',
                          onPressed: () async {
                            String? bankName;
                            bankName = selectedRadioValue;
                            await cPayment.paymentConsultation(
                              (selectedRadioValue == "bni" ||
                                  selectedRadioValue == "bri" ||
                                  selectedRadioValue == "bca")
                                  ? "bank_transfer"
                                  : "echannel",
                              totalPayment,
                              widget.doctor.id ?? 0,
                              widget.doctor.name ?? "",
                              widget.doctor.consultationPrice ?? "",
                              cHome.profileResponse.data?.name ?? "",
                              "-",
                              cHome.profileResponse.data?.email ?? "",
                              cHome.profileResponse.data?.phoneNumber ?? "",
                              bankName ?? "",
                              widget.doctor.photo ?? ""
                            );
                            if (cPayment.isSuccessfull) {
                              Get.to(ConfirmPaymentScreen(
                                doctor: widget.doctor,
                              ));
                            } else {
                              Get.snackbar(
                                "Error",
                                cPayment.message,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

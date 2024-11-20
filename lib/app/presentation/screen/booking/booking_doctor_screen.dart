import 'package:GoDentist/app/data/models/clinic/detail_clinic_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_clinic.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:GoDentist/app/presentation/controllers/c_payment.dart';
import 'package:GoDentist/app/presentation/screen/booking/confirm_booking_payement_screen.dart';
import 'package:GoDentist/app/presentation/screen/booking/result_booking_doctor_screen.dart';
import 'package:GoDentist/app/presentation/widgets/button.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingDoctorScreen extends StatefulWidget {
  final Doctor doctor;
  final DoctorWorkSchedule doctorWorkSchedule;
  final Clinic clinic;
  final int idClinic;

  const BookingDoctorScreen({required this.doctor,required this.clinic, required this.idClinic, required this.doctorWorkSchedule, Key? key}) : super(key: key);

  @override
  State<BookingDoctorScreen> createState() => _BookingDoctorScreenState();
}

class _BookingDoctorScreenState extends State<BookingDoctorScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  // Fungsi untuk memformat TimeOfDay menjadi string "HH:mm"
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  Future _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      Map<String, int> dayOfWeekMapping = {
        'Senin': DateTime.monday,
        'Selasa': DateTime.tuesday,
        'Rabu': DateTime.wednesday,
        'Kamis': DateTime.thursday,
        'Jumat': DateTime.friday,
        'Sabtu': DateTime.saturday,
        'Minggu': DateTime.sunday,
      };

      // Mendapatkan urutan hari dari fromDay dan untilDay
      int fromDay = dayOfWeekMapping[widget.doctorWorkSchedule.fromDay!]!;
      int untilDay = dayOfWeekMapping[widget.doctorWorkSchedule.untilDay!]!;

      // Mengonversi tanggal yang dipilih menjadi urutan hari dalam seminggu
      int selectedDay = picked.weekday;

      // Periksa apakah urutan hari yang dipilih berada dalam rentang hari kerja dokter
      if (selectedDay >= fromDay && selectedDay <= untilDay) {
// Jika ya, update tanggal yang dipilih
        setState(() {
          selectedDate = picked;
        });
      } else {
// Jika tidak, tampilkan pesan peringatan
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text('Dokter tidak bekerja pada hari ini.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Pilih Waktu Mulai',
    );
    if (picked != null && picked != selectedStartTime) {
      // Mendapatkan jam awal dan jam akhir dari jadwal dokter
      int fromHour =
          int.parse(widget.doctorWorkSchedule.fromHour?.split(':')[0] ?? '8');
      int untilHour =
          int.parse(widget.doctorWorkSchedule.untilHour?.split(':')[0] ?? '22');

      // Periksa apakah waktu yang dipilih berada dalam jadwal kerja dokter
      if (picked.hour >= fromHour && picked.hour < untilHour) {
        setState(() {
          selectedStartTime = picked;
        });
      } else {
        // Tampilkan pesan kesalahan jika waktu yang dipilih di luar jangkauan yang diizinkan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Anda hanya dapat memilih waktu konsultasi dari jam $fromHour:00 hingga jam $untilHour:00.'),
          ),
        );
      }
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Pilih Waktu Selesai',
    );
    if (picked != null && picked != selectedEndTime) {
      // Mendapatkan jam awal dan jam akhir dari jadwal dokter
      int fromHour =
          int.parse(widget.doctorWorkSchedule.fromHour?.split(':')[0] ?? '8');
      int untilHour =
          int.parse(widget.doctorWorkSchedule.untilHour?.split(':')[0] ?? '22');

      // Periksa apakah waktu yang dipilih berada dalam jadwal kerja dokter
      if (picked.hour >= fromHour && picked.hour < untilHour) {
        setState(() {
          selectedEndTime = picked;
        });
      } else {
        // Tampilkan pesan kesalahan jika waktu yang dipilih di luar jangkauan yang diizinkan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Anda hanya dapat memilih waktu konsultasi dari jam $fromHour:00 hingga jam $untilHour:00.'),
          ),
        );
      }
    }
  }

  List<ClinicService> selectedServices = [];

  // Membuat daftar CheckBox berdasarkan layanan klinik yang tersedia
  Widget buildServiceCheckboxes(List<ClinicService> services) {
    return ExpansionTile(
      title: Text('Pilih Layanan'),
      children: services.map((service) {
        return CheckboxListTile(
          title: Text(service.serviceName ?? ''),
          value: selectedServices.contains(service),
          onChanged: (bool? value) {
            setState(() {
              if (value ?? false) {
                selectedServices.add(service);
              } else {
                selectedServices.remove(service);
              }
              updateTotalCost(); // Memperbarui total biaya saat pilihan layanan berubah
            });
          },
        );
      }).toList(),
    );
  }

  // Mengubah layanan klinik yang dipilih menjadi daftar id layanan
  List<int> getSelectedServiceIds() {
    return selectedServices.map((service) => service.id ?? 0).toList();
  }

  double totalCost = 0.0;

  // Fungsi untuk memperbarui total biaya layanan yang dipilih
  void updateTotalCost() {
    double cost = 0.0;
    // Iterasi melalui layanan yang dipilih dan menambahkan harganya ke total
    for (var service in selectedServices) {
      cost += double.parse(service.price ?? '0.0');
    }
    // Update total biaya
    setState(() {
      totalCost = cost;
    });
  }

  String? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = "bni"; // Beri nilai awal pada initState
  }

  final _paymentMethods = [
    PaymentMethodItem(
      name: "BNI Virtual Account",
      value: "bni",
      image: 'assets/images/bni.png',
    ),
    PaymentMethodItem(
      name: "Mandiri Virtual Account",
      value: "mandiri",
      image: 'assets/images/mandiri.png',
    ),
    PaymentMethodItem(
      name: "BRI Virtual Account",
      value: "bri",
      image: 'assets/images/bri.png',
    ),
    PaymentMethodItem(
      name: "BCA Virtual Account",
      value: "bca",
      image: 'assets/images/bca.png',
    ),
    PaymentMethodItem(
      name: 'Pembayaran Offline',
      value: 'offline',
      icon: Icons.account_balance_wallet
    )
  ];

  @override
  Widget build(BuildContext context) {
    final cClinic = Get.put(CClinic());
    final cPayment = Get.put(CPayment());
    final cHome = Get.put(CHome());
    final cLogin = CLogin.instance;
    return Obx(
      () => cPayment.isFetching
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Booking Dokter',
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
              body: Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(widget.doctor.photo ?? ""),
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
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cClinic.detailClinicResponse.data!.clinic!
                                        .name!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${cClinic.detailClinicResponse.data!.clinic!.address!}, ${cClinic.detailClinicResponse.data!.clinic!.subDistrict!}, ${cClinic.detailClinicResponse.data!.clinic!.city!}, ${cClinic.detailClinicResponse.data!.clinic!.province!}",
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
                              backgroundImage: NetworkImage(cClinic
                                  .detailClinicResponse
                                  .data!
                                  .clinic!
                                  .photoUrl!),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Pilih Jadwal Booking',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstant.blackColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  InkWell(
                                    onTap: () {
                                      _selectedDate(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: ColorConstant.primaryColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${selectedDate.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstant.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jam',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstant.blackColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _selectStartTime(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: ColorConstant.primaryColor,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              selectedStartTime != null
                                                  ? _formatTimeOfDay(
                                                      selectedStartTime!)
                                                  : 'Jam Mulai',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      _selectEndTime(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: ColorConstant.primaryColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          selectedEndTime != null
                                              ? _formatTimeOfDay(
                                                  selectedEndTime!)
                                              : 'Jam Berakhir',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Kategori Pemeriksaan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      buildServiceCheckboxes(cClinic.detailClinicResponse.data!.clinicService!),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 100),
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
                            ..._paymentMethods.map((e) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPaymentMethod = e.value;
                                  });
                                },
                                child: Row(
                                  children: [
                                    if(e.image != null)
                                      Image.asset(e.image!, width: 30),
                                    if(e.icon != null)
                                      SizedBox(
                                        width: 30,
                                        child: Icon(e.icon!, color: ColorConstant.primaryColor),
                                      ),
                                    SizedBox(width: 12),
                                    Text(
                                      e.name,
                                      style: TextStyle(color: ColorConstant.blackColor, fontSize: 12,),
                                    ),
                                    Spacer(),
                                    Radio(
                                      value: e.value,
                                      groupValue: selectedPaymentMethod, // Gunakan variabel selectedRadioValue
                                      onChanged: (value) {
                                        // Ubah nilai selectedRadioValue ketika radio button dipilih
                                        setState(() {
                                          selectedPaymentMethod = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
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
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      margin: EdgeInsets.only(bottom: 16),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Biaya',
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Rp. ${totalCost.toInt()}',
                                style: TextStyle(
                                  color: ColorConstant.redColor,
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
                              text: 'Booking',
                              onPressed: () async {
                                if(selectedStartTime == null) {
                                  Get.snackbar("Perhatian", "Harap mengisi jam mulai !");
                                  return;
                                } else if(selectedEndTime == null) {
                                  Get.snackbar("Perhatian", "Harap mengisi jam berakhir !");
                                  return;
                                } else if(selectedServices.isEmpty) {
                                  Get.snackbar("Perhatian", "Harap memilih jenis pemeriksaan");
                                  return;
                                }
                                String paymentMethod = '';
                                if(selectedPaymentMethod == "bni" || selectedPaymentMethod == "bri" || selectedPaymentMethod == "bca") {
                                  paymentMethod = 'bank_transfer';
                                } else if(selectedPaymentMethod == 'mandiri') {
                                  paymentMethod = 'echannel';
                                } else {
                                  paymentMethod = 'cash_on_delivery';
                                }
                                await cPayment.paymentBookingDoctor(
                                  paymentMethod,
                                  totalCost.toInt(),
                                  widget.idClinic,
                                  widget.doctor.id ?? 0,
                                  cLogin.loginResponse.data?.id ?? 0,
                                  cClinic.detailClinicResponse.data?.clinic!.name ?? "",
                                  widget.doctor.name ?? "",
                                  widget.doctor.specialization ?? "",
                                  selectedDate.toString(),
                                  _formatTimeOfDay(selectedStartTime!),
                                  _formatTimeOfDay(selectedEndTime!),
                                  getSelectedServiceIds(),
                                  selectedServices
                                      .map((service) => service.serviceName!)
                                      .toList(),
                                  selectedServices
                                      .map((service) => service.price!)
                                      .toList(),
                                  "pending",
                                  "online",
                                  cHome.profileResponse.data?.name ?? "",
                                  "-",
                                  cHome.profileResponse.data?.email ?? "",
                                  cHome.profileResponse.data?.phoneNumber ?? "",
                                  selectedPaymentMethod ?? "",
                                  widget.doctor.photo.toString(),
                                  isCOD: paymentMethod == 'cash_on_delivery'
                                );
                                if(selectedPaymentMethod == 'offline') {
                                  Get.offAll(() => ResultBookingDoctorScreen(
                                    doctor: widget.doctor,
                                    clinicData: widget.clinic,
                                    isCOD: true,
                                  ));
                                  Get.snackbar(
                                    "Berhasil",
                                    "Kamu berhasil booking klinik",
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                }
                                else if (cPayment.isSuccessfull) {
                                  Get.to(() => ConfirmPaymentBooking(
                                    cost: totalCost.toString(),
                                    doctor: widget.doctor,
                                    clinicData: widget.clinic,
                                  ));
                                }
                                else {
                                  Get.snackbar(
                                    'Failed',
                                    cPayment.paymentBookingResponse.message ?? "Failed get payment",
                                    backgroundColor: Colors.red,
                                  );
                                }
                              },
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
  }
}

class PaymentMethodItem {
  final String name;
  final String? image;
  final String value;
  final IconData? icon;

  PaymentMethodItem({
    required this.name,
    required this.value,
    this.image,
    this.icon,
  });
}

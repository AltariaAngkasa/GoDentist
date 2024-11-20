import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<XFile?> selectImageFromGalery() async {
    XFile? selectImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return selectImage;
  }

  static Future<XFile?> selectImageFromCamera() async {
    XFile? selectImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    return selectImage;
  }
}

// Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.fromLTRB(20, 16, 16, 20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 1,
                //         offset: Offset(0, 1),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           CircleAvatar(
                //             radius: 40,
                //             backgroundColor: Colors
                //                 .grey, // Warna latar belakang untuk avatar
                //             child: Image(
                //               image: NetworkImage(doctor.photo ??
                //                   "https://via.placeholder.com/150"),
                //               errorBuilder: (context, error, stackTrace) {
                //                 // Tampilkan avatar cadangan atau pesan kesalahan di dalam CircleAvatar
                //                 return Icon(
                //                   Icons.error,
                //                   color: Colors.white,
                //                   size: 80,
                //                 ); // Contoh menampilkan ikon error
                //               },
                //             ),
                //           ),
                //           SizedBox(width: 24),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 doctor.name != null && doctor.name!.length > 15
                //                     ? "${doctor.name!.substring(0, 15)}..."
                //                     : doctor.name ?? "",
                //                 maxLines: 1,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Text(
                //                 "Dokter ${doctor.specialization}",
                //                 style: TextStyle(
                //                   fontSize: 10,
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Text(
                //                 "Online",
                //                 style: TextStyle(
                //                   fontSize: 10,
                //                   color: Colors.green,
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Text(
                //                 doctor.workPlace ?? "",
                //                 style: TextStyle(
                //                   fontSize: 10,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 1,
                //         offset: Offset(0, 1),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Detail Pembayaran",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       SizedBox(
                //         height: 16,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Biaya Konsultasi 30 Menit',
                //             style: TextStyle(
                //               fontSize: 12,
                //             ),
                //           ),
                //           Text(
                //             doctor.consultationPrice != null
                //                 ? "Rp. ${doctor.consultationPrice}"
                //                 : "Rp. 0",
                //             style: TextStyle(
                //               fontSize: 12,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: const [
                //           Text(
                //             'Biaya Layanan Aplikasi',
                //             style: TextStyle(
                //               fontSize: 12,
                //             ),
                //           ),
                //           Text(
                //             "Rp. 1000",
                //             style: TextStyle(
                //               fontSize: 12,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 16,
                //       ),
                //       Container(
                //         height: 1,
                //         color: Colors.grey,
                //       ),
                //       SizedBox(
                //         height: 8,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: const [
                //           Text(
                //             'Total Biaya',
                //             style: TextStyle(
                //               fontSize: 12,
                //             ),
                //           ),
                //           Text(
                //             "Rp. 11.000",
                //             style: TextStyle(
                //               fontSize: 12,
                //               color: Colors.red,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 1,
                //         offset: Offset(0, 1),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Metode Pembayaran",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       SizedBox(
                //         height: 16,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Image.asset(
                //             'assets/images/gopay.png',
                //             fit: BoxFit.cover,
                //           ),
                //           Radio(
                //             value: 0,
                //             groupValue: 0,
                //             onChanged: (value) {},
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 16,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Image.asset(
                //             'assets/images/visa.png',
                //             fit: BoxFit.cover,
                //           ),
                //           Radio(
                //             value: 1,
                //             groupValue: 0,
                //             onChanged: (value) {},
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 16,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Image.asset(
                //             'assets/images/qris.png',
                //             fit: BoxFit.cover,
                //           ),
                //           Radio(
                //             value: 2,
                //             groupValue: 0,
                //             onChanged: (value) {},
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Spacer(),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                //   child: Button(
                //     onPressed: () async {
                //       await cPayment.paymentConsultation(
                //         15000,
                //         doctor.id ?? 0,
                //         doctor.name ?? "",
                //         doctor.consultationPrice ?? "",
                //         cHome.profileResponse.data?.name ?? "",
                //         "-",
                //         cHome.profileResponse.data?.email ?? "",
                //         cHome.profileResponse.data?.phoneNumber ?? "",
                //         "bri",
                //       );
                //       if (cPayment.isSuccessfull) {
                //         Get.snackbar(
                //           "Success",
                //           cPayment.message,
                //           backgroundColor: Colors.green,
                //           colorText: Colors.white,
                //         );
                //         Get.to(() => ConfirmPaymentScreen(
                //             // midtransResponse: cPayment
                //             //     .paymentConsultationResponse
                //             //     .data!
                //             //     .midtransResponse!
                //             ));
                //       } else {
                //         Get.snackbar(
                //           "Error",
                //           cPayment.message,
                //           backgroundColor: Colors.red,
                //           colorText: Colors.white,
                //         );
                //       }
                //       // print(cHome.profileResponse.data?.name ?? "apapapa");
                //       // print(cHome.profileResponse.data?.email ?? "apapapa");
                //     },
                //     color: ColorConstant.redColor,
                //     text: 'Bayar',
                //     size: 14,
                //   ),
                // ),
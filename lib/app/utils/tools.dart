import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if(dateString == null) return "-";
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat.yMMMMd('id_ID').format(dateTime);
}

String formatTime(String timeString) {
  List<String> parts = timeString.split(':');
  if (parts.length >= 2) {
    return '${parts[0]}:${parts[1]}'; // Mengambil jam dan menit
  } else {
    return timeString; // Mengembalikan string asli jika format tidak sesuai
  }
}

String getPaymentGuide(String paymentType) {
  switch(paymentType) {
    case "bni":
      return "1. Pilih menu Transfer antar bank atau Transfer online antar bank."
          "\n2. Masukkan kode bank BNI (009) atau pilih bank yang dituju yaitu BNI."
          "\n3. Masukan 16 Digit Nomor Virtual Account pada kolom rekening tujuan (Contoh: 8277087781881441)."
          "\n4. Masukkan nominal transfer sesuai tagihan Anda. Nominal yang berbeda tidak dapat diproses."
          "\n5. Masukkan jumlah pembayaran. (Contoh: 253000)."
          "\n6. Konfirmasi rincian Anda akan tampil pada layar."
          "\n7. Jika sudah sesuai, klik Ya untuk melanjutkan."
          "\n8. Transaksi Anda telah berhasil.";
    case 'mandiri':
      return "1. Pilih 'Pembayaran' pada menu utama"
          "\n2. Pilih 'Ecommerce"
          "\n3. Pilih 'Midtrans' pada layanan"
          "\n4. Input nomor virtual account pada kolom kode pembayaran"
          "\n5. Klik 'Lanjutkan' untuk konfirmasi"
          "\n6. Pembayaran berhasil";
    case 'bca':
      return "1. Pilih m-transfer"
          "\n2. Pilih BCA Virtual Account"
          "\n3. Masukkan nomor virtial account BCA"
          "\n4. Masukkan jumlah pembayaran, lalu tekan konfirmasi"
          "\n5. Pembayaran berhasil";
    case 'bri':
      return "1. Pilih pembayaran"
          "\n2. Pilih BRIVA"
          "\n3. Masukkan nomor BRIVA, lalu tekan konfirmasi"
          "\n4. Pembayaran berhasil";
    default:
      return "";
  }
}

bool isTabletMode(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth > 550;
}
import 'dart:async';

import 'package:GoDentist/app/data/models/payments/check_booking_doctor_payment_response.dart';
import 'package:GoDentist/app/data/models/payments/check_payment_consultation_response.dart';
import 'package:GoDentist/app/data/models/payments/payment_booking_doctor_response.dart';
import 'package:GoDentist/app/data/models/payments/payment_consultation_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:GoDentist/app/presentation/controllers/c_doctor.dart';
import 'package:get/get.dart';

class CPayment extends CCommon {
  final apiService = ApiService();
  final cDoctor = Get.put(CDoctor());

  final Rx<PaymentConsultationResponse> _paymentConsultationResponse = PaymentConsultationResponse().obs;
  PaymentConsultationResponse get paymentConsultationResponse => _paymentConsultationResponse.value;
  set paymentConsultationResponse(PaymentConsultationResponse newValue) {
    _paymentConsultationResponse.value = newValue;
  }

  final Rx<CheckPaymentConsultationResponse> _checkPaymentConsultationResponse = CheckPaymentConsultationResponse().obs;
  CheckPaymentConsultationResponse get checkPaymentConsultationResponse => _checkPaymentConsultationResponse.value;
  set checkPaymentConsultationResponse(CheckPaymentConsultationResponse newValue) {
    _checkPaymentConsultationResponse.value = newValue;
  }

  final Rx<PaymentBookingDoctorResponse> _paymentBookingResponse = PaymentBookingDoctorResponse().obs;
  PaymentBookingDoctorResponse get paymentBookingResponse => _paymentBookingResponse.value;
  set paymentBookingResponse(PaymentBookingDoctorResponse newValue) {
    _paymentBookingResponse.value = newValue;
  }

  final Rx<CheckPaymentBookingDoctorResponse>_checkPaymentBookingDoctorResponse = CheckPaymentBookingDoctorResponse().obs;
  CheckPaymentBookingDoctorResponse get checkPaymentBookingDoctorResponse => _checkPaymentBookingDoctorResponse.value;
  set checkPaymentBookingDoctorResponse(CheckPaymentBookingDoctorResponse newValue) {
    _checkPaymentBookingDoctorResponse.value = newValue;
  }


  Future paymentConsultation(
    String paymentType,
    int amount,
    int itemId,
    String itemName,
    String consultationPrice,
    String firstName,
    String lastName,
    String email,
    String phone,
    String bankName,
    String photo,
  ) async {
    isFetching = true;
    final result = await apiService.paymentConsultation(
        paymentType,
        amount,
        itemId,
        itemName,
        consultationPrice,
        firstName,
        lastName,
        email,
        phone,
        bankName,
        photo
    );
    result.when(
      success: (data) {
        paymentConsultationResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = paymentConsultationResponse.message ?? "Successfull get payment";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future getStatusPaymentConsultation(
    String orderId,
    String transactionID,
  ) async {
    isFetching = true;
    final result = await apiService.getStatusPaymentConsultation(
      orderId,
      transactionID,
    );
    result.when(
      success: (data) {
        checkPaymentConsultationResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = checkPaymentConsultationResponse.message ??
            "Successfull get payment";
        print(checkPaymentConsultationResponse.toJson());
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future paymentBookingDoctor(
    String paymentType,
    int amount,
    int idClinic,
    int idDoctor,
    int idPatient,
    String clinicName,
    String doctorName,
    String doctorSpecialization,
    String date,
    String startTime,
    String endTime,
    List<int> idServices,
    List<String> servicesName,
    List<String> servicesPrice,
    String statusService,
    String statusBooking,
    String firstName,
    String lastName,
    String email,
    String phone,
    String bankName,
    String photo,
    {bool isCOD = false}
  ) async {
    isFetching = true;
    final result = await apiService.bookingDoctor(
      paymentType,
      amount,
      idClinic,
      idDoctor,
      idPatient,
      clinicName,
      doctorName,
      doctorSpecialization,
      date,
      startTime,
      endTime,
      idServices,
      servicesName,
      servicesPrice,
      statusService,
      statusBooking,
      firstName,
      lastName,
      email,
      phone,
      bankName,
      photo,
      isCOD: isCOD
    );
    result.when(
      success: (data) {
        paymentBookingResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = paymentBookingResponse.message ?? "Successfull Booking Doctor";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future getStatusPaymentBookingDoctor(
    String orderId,
    String transactionID,
  ) async {
    isFetching = true;
    final result = await apiService.getStatusPaymentBookingDoctor(orderId, transactionID);
    result.when(
      success: (data) {
        checkPaymentBookingDoctorResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = checkPaymentBookingDoctorResponse.message ?? "Successfull check Booking Doctor";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }
}

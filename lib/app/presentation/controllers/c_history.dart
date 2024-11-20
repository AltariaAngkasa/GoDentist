import 'package:GoDentist/app/data/models/history/get_consultation_history_response.dart';
import 'package:GoDentist/app/data/models/history/history_booking_clinic_response.dart';
import 'package:GoDentist/app/data/models/history/history_consultation_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CHistory extends CCommon {
  final apiService = ApiService();

  final Rx<HistoryConsultationResponse> _historyConsultationResponse = HistoryConsultationResponse().obs;
  HistoryConsultationResponse get historyConsultationResponse => _historyConsultationResponse.value;
  set historyConsultationResponse(HistoryConsultationResponse newValue) {
    _historyConsultationResponse.value = newValue;
  }
  RxBool isFetchingConsultation = false.obs;

  final Rx<HistoryBookingClinicResponse> _historyBookingClinicResponse = HistoryBookingClinicResponse().obs;
  HistoryBookingClinicResponse get historyBookingClinicResponse => _historyBookingClinicResponse.value;
  set historyBookingClinicResponse(HistoryBookingClinicResponse newValue) {
    _historyBookingClinicResponse.value = newValue;
  }
  RxBool isFetchingBooking = false.obs;

  final Rx<GetConsultationHistoryResponse> consultationHistory = GetConsultationHistoryResponse().obs;
  GetConsultationHistoryResponse get consultationHistoryValue => consultationHistory.value;
  set consultationHistoryValue(GetConsultationHistoryResponse newValue) {
    consultationHistory.value = newValue;
  }

  Future getHistoryConsultation() async {
    isFetchingConsultation.value = true;
    final result = await apiService.getHistoryConsultation();
    result.when(
      success: (data) {
        historyConsultationResponse = data;
        isSuccessfull = true;
        isFetchingConsultation.value = false;
        message = historyConsultationResponse.message ?? "Successfull get doctor";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetchingConsultation.value = false;
      },
    );
  }

  Future getHistoryBookingClinic() async {
    isFetchingBooking.value = true;
    final result = await apiService.getHistoryBookingClinic();
    result.when(
      success: (data) {
        debugPrint("SUCCESS GET HISTORY BOOKING : ${data.toJson()}");
        historyBookingClinicResponse = data;
        isSuccessfull = true;
        isFetchingBooking.value = false;
        message = historyConsultationResponse.message ?? "Successfull get History Booking Clinic";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetchingBooking.value = false;
      },
    );
  }

  Future createHistoryChat({required String orderId, required String idRoomChat}) async {
    isFetching = true;
    final result = await apiService.createHistoryChat(orderId: orderId, idRoomChat: idRoomChat);
    result.when(
      success: (data) {
        debugPrint("SUCCESS CREATE HISTORY CHAT : $data");
      },
      failure: (error, stackTrace) {
        debugPrint("ERROR CREATE HISTORY CHAT : $error $stackTrace");
      },
    );
  }

  Future getConsultationHistory({required String orderId}) async {
    isFetching = true;
    final result = await apiService.getConsultationHistory(orderId: orderId);
    result.when(
      success: (data) {
        consultationHistoryValue = data;
        isSuccessfull = true;
        isFetching = false;
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        isFetching  = false;
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await getHistoryBookingClinic();
    await getHistoryConsultation();
  }
}

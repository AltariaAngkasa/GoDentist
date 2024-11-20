import 'package:GoDentist/app/data/models/clinic/clinic_response.dart';
import 'package:GoDentist/app/data/models/clinic/detail_clinic_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CClinic extends CCommon {
  final apiService = ApiService();
  final cHome = Get.put(CHome());

  final Rx<DetailClinicResponse> _detailClinicResponse = DetailClinicResponse().obs;
  DetailClinicResponse get detailClinicResponse => _detailClinicResponse.value;
  set detailClinicResponse(DetailClinicResponse newValue) {
    _detailClinicResponse.value = newValue;
  }

  final TextEditingController searchQuery = TextEditingController();

  Future detailClinicById(int id) async {
    isFetching = true;
    final result = await apiService.detailClinicById(id);
    result.when(
      success: (data) {
        detailClinicResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message =
            detailClinicResponse.message ?? "Successfull get Detail Clinic";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future searchClinic(String name) async {
    isFetching = true;
    final result = await apiService.searchClinic(name);
    result.when(
      success: (data) {
        cHome.clinicResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = cHome.clinicResponse.message ?? "Successfull search clinic";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

}
